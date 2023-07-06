import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/detail_page.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/detail_element.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/ver_repo_header.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_list_view.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_app_bar.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';

import '../test/repository/repository_mock_data.dart';
import '../test/repository/repository_mock_test.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('入力→結果が表示される→タップで画面遷移→遷移後に情報が表示されているか',
      (WidgetTester tester) async {
    //モックのデータをshared_preferencesにセットしておかないといけない
    SharedPreferences.setMockInitialValues({});
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    await tester.pumpWidget(
      ProviderScope(overrides: [
        //mock clientでDI
        httpClientProvider.overrideWithValue(mockClient),
        //sharedPreferencesを初回で上書き
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ], child: const MyApp()),
    );

    //検索ページのアップバーが表示されているか
    expect(find.byKey(SearchAppBar.appBarKey), findsOneWidget);

    final formField = find.byKey(SearchBar.inputFormKey);

    //flutterと入力して検索する
    await tester.tap(formField);
    await tester.enterText(formField, 'flutter');
    //検索ボタンを押す
    await tester.testTextInput.receiveAction(TextInputAction.search);

    //shimmerが描画される
    await tester.pump();
    //リストの描画
    await tester.pump();

    //"flutter/flutter" の文字が見つかるか
    final tapTarget = find.text('flutter/flutter');
    expect(tapTarget, findsOneWidget);
    //ユーザーアイコンが表示されるか
    expect(find.byKey(ListItem.userImageKey), findsWidgets);
    //検索結果数が表示されるか
    expect(find.byKey(ResultListview.resultCountKey), findsOneWidget);

    //リストをタップ→詳細ページに遷移
    await tester.tap(tapTarget);

    //画面遷移するまで待つ
    await tester.pumpAndSettle();

    //詳細ページのアップバーが表示されるか
    expect(find.byKey(DetailPage.appBarKey), findsOneWidget);
    //ユーザーのアイコンが表示されるか
    expect(find.byKey(VerRepoHeader.userImageKey), findsOneWidget);
    //詳細ページのレポジトリ名が表示される
    expect(find.byKey(VerRepoHeader.repoNameKey), findsOneWidget);
    // //詳細ページのレポジトリ詳細が表示される
    expect(find.byKey(VerRepoHeader.repoDetailKey), findsOneWidget);

    //その他の情報が表示されるか
    expect(find.byKey(DetailElement.languageKey), findsOneWidget);
    expect(find.byKey(DetailElement.starKey), findsOneWidget);
    expect(find.byKey(DetailElement.watchKey), findsOneWidget);
    expect(find.byKey(DetailElement.forkKey), findsOneWidget);
    expect(find.byKey(DetailElement.issueKey), findsOneWidget);
    expect(find.byKey(DetailPage.viewOnGithubKey), findsOneWidget);
  });
}
