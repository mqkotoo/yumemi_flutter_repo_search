import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
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
    expect(find.byKey(const Key('searchPageAppBar')), findsOneWidget);

    final formField = find.byKey(const Key('inputForm'));

    //flutterと入力して検索する
    await tester.enterText(formField, 'flutter');
    await tester.tap(formField);
    //検索ボタンを押す
    await tester.testTextInput.receiveAction(TextInputAction.search);

    //リストが描画される
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    //"flutter/flutter" と言う文字が見つかるか
    final tapTarget = find.text('flutter/flutter');
    expect(tapTarget, findsOneWidget);
    //ユーザーアイコンが表示されるか
    expect(find.byKey(const Key('userImageOnListView')), findsOneWidget);
    //検索結果数が表示されるか
    expect(find.byKey(const Key('resultCount')), findsOneWidget);

    //リストをタップ→詳細ページに遷移
    await tester.tap(tapTarget);

    //画面遷移するまで待つ
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    //詳細ページのアップバーが表示されるか
    expect(find.byKey(const Key('detailPageAppBar')), findsOneWidget);
    //ユーザーのアイコンが表示されるか
    expect(find.byKey(const Key('userImageOnDetailPage')), findsOneWidget);
    //詳細ページのレポジトリ名が表示される
    expect(find.byKey(const Key('repoNameOnDetailPage')), findsOneWidget);
    //詳細ページのレポジトリ詳細が表示される
    expect(find.byKey(const Key('repoDetailOnDetailPage')), findsOneWidget);

    //その他の情報が表示されるか
    expect(find.byKey(const Key('language')), findsOneWidget);
    expect(find.byKey(const Key('star')), findsOneWidget);
    expect(find.byKey(const Key('watch')), findsOneWidget);
    expect(find.byKey(const Key('fork')), findsOneWidget);
    expect(find.byKey(const Key('issue')), findsOneWidget);
    expect(find.byKey(const Key('viewOnGithub')), findsOneWidget);
  });
}
