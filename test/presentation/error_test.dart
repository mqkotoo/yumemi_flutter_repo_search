import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';
import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';

void main() {
  group('エラー等の表示ができているか', () {
    testWidgets('空文字を入力して”入力してください”が表示されるか', (WidgetTester tester) async {
      //モックのデータをshared_preferencesにセットしておかないといけない
      SharedPreferences.setMockInitialValues({});
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      //空文字を送信するとリクエストはせず、エラーメッセージを表示する仕様
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      //""と入力して検索する
      final formField = find.byKey(SearchBar.inputFormKey);
      await tester.enterText(formField, '');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pump();

      //エラーが返ってくる("テキストを入力してください")
      expect(find.byKey(EnterTextView.enterTextViewKey), findsOneWidget);
    });

    testWidgets('結果が0だった時に、想定の表示がされるか', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const emptyData = RepositoryMockData.emptyJsonData;
      final mockClient = MockClient();
      //結果が0のデータを返す
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(emptyData, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      //入力して検索する
      final formField = find.byKey(SearchBar.inputFormKey);
      await tester.enterText(formField, 'kjsdf；ヵjdf；kぁjsdfj');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //結果表示されるまで待つ
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      //エラーが返ってくる("検索結果が見つからない")
      expect(find.byKey(NoResultView.noResultViewKey), findsOneWidget);
    });

    testWidgets('リクエストが200以外の場合エラーが返るか', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      //リクエストが200以外（失敗）する想定
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 403));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      //"flutter"と入力して検索する
      final formField = find.byKey(SearchBar.inputFormKey);
      await tester.enterText(formField, 'flutter');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //エラー表示されるまで待つ
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      //エラーが返ってくる
      expect(find.byKey(ErrorView.errorViewKey), findsOneWidget);
    });

    testWidgets('通信状態じゃない時の検索でネットワークエラーが返るか', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      //リクエストを投げると、ネットワークエラーの例外をスローする
      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => throw NoInternetException());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            httpClientProvider.overrideWithValue(mockClient),
            sharedPreferencesProvider.overrideWithValue(
              await SharedPreferences.getInstance(),
            ),
          ],
          child: const MyApp(),
        ),
      );

      //"flutter"と入力して検索する
      final formField = find.byKey(SearchBar.inputFormKey);
      await tester.enterText(formField, 'flutter');
      //検索ボタンを押す
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //エラーが表示されるまで待つ
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      //トップの結果は表示されない
      expect(find.textContaining('flutter/flutter'), findsNothing);

      //想定エラー文
      expect(find.byKey(NetworkErrorView.networkErrorViewKey), findsOneWidget);
    });
  });
}
