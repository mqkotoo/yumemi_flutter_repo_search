import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/generated/l10n.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_page.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';
import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';

void main() {
  group('入力フォームのテスト', () {
    //hintテキストのテストをするので言語を指定
    Widget myTestWidget() {
      return MaterialApp(
        //多言語対応
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('en'),
        home: const SearchPage(),
      );
    }

    testWidgets('検索フォームのテスト', (WidgetTester tester) async {
      //モックのデータをshared_preferencesにセットしておかないといけない
      SharedPreferences.setMockInitialValues({});
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          //mock clientでDI
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: myTestWidget()),
      );
      //検索フォーム
      final formField = find.byKey(const Key('inputForm'));
      //検索フォームがあるか
      expect(formField, findsOneWidget);
      //初期状態でヒントテキストが表示されているか
      expect(find.text('Search Repository'), findsOneWidget);
      //検索アイコンが表示されているか
      expect(find.byIcon(Icons.search), findsOneWidget);
      //初期状態ではクリアボタン（削除）は表示されない
      final clearButton = find.byIcon(Icons.clear);
      expect(clearButton, findsNothing);
      //検索フォームに文字が入力できるか
      await tester.enterText(formField, 'こんにちは');
      expect(find.text('こんにちは'), findsOneWidget);

      //描画待ち
      await tester.pump();

      //文字が入力されているとクリアボタンが表示されている
      expect(clearButton, findsOneWidget);
      //文字を消す
      await tester.tap(clearButton);
      //「こんにちは」が削除されている
      expect(find.text('こんにちは'), findsNothing);
      //入力なくなったらヒントテキストが表示される
      expect(find.text('Search Repository'), findsOneWidget);
    });
  });

  group('リポジトリの検索に関するテスト', () {
    testWidgets('検索結果が表示されるか', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          //mock clientでDI
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      //検索フォーム
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
    });
  });

  group('詳細ページのテスト', () {
    testWidgets('遷移先の詳細ページの表示ができているか', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          //mock clientでDI
          httpClientProvider.overrideWithValue(mockClient),
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      //検索フォーム
      final formField = find.byKey(const Key('inputForm'));
      //flutterと入力して検索する
      await tester.enterText(formField, 'flutter');
      await tester.tap(formField);
      //検索ボタンを押す
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //リストが描画される
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();

      //リストをタップ→詳細ページに遷移
      final tapTarget = find.text('flutter/flutter');
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
  });
}
