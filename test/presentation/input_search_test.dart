// import 'package:flutter/material.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:yumemi_flutter_repo_search/main.dart';
// import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
//
// import '../repository/repository_mock_data.dart';
// import '../repository/repository_mock_test.mocks.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';

import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';

void main() {
  group('入力、検索に関するテスト', () {
    testWidgets('入力→結果が表示される→タップで画面遷移→遷移後に情報が表示されているか',
        (WidgetTester tester) async {
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          //mock clientでDI
          httpClientProvider.overrideWithValue(mockClient),
        ], child: const MyApp()),
      );

      //検索ページのアップバーが表示されているか
      expect(find.byKey(const Key('searchPageAppBar')), findsOneWidget);

      final formField = find.byKey(const Key('inputForm'));

      //検索フォームに文字が入力できるか
      await tester.enterText(formField, 'こんにちは');
      expect(find.text('こんにちは'), findsOneWidget);

      await tester.pump();

      //文字を消す
      final clearButton = find.byKey(const Key('clearButton'));
      await tester.tap(clearButton);
      //「こんにちは」が削除されている
      expect(find.text('こんにちは'), findsNothing);

      //flutterと入力して検索する
      await tester.enterText(formField, 'flutter');
      await tester.tap(formField);
      //検索ボタンを押す
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //リストが描画される
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();

      final tapTarget = find.textContaining('flutter/flutter');
      //結果が表示されるか
      expect(find.byKey(const Key('resultCount')), findsOneWidget);
      //"flutter/flutter" と言う文字が見つかるか
      expect(tapTarget, findsOneWidget);
      //ユーザーアイコンが表示されるか
      expect(find.byKey(const Key('userImageOnListView')), findsOneWidget);

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
      //fork表示されるか
      expect(find.byKey(const Key('fork')), findsNothing);
    });
  });
}
