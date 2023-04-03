import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';

import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  group('エラー等の表示ができているか', () {
    testWidgets('空文字を入力して”入力してください”が表示されるか', (WidgetTester tester) async {
      const data = RepositoryMockData.jsonData;
      final mockClient = MockClient();
      //空文字を送信するとリクエストはせず、エラーメッセージを表示する仕様
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
        ], child: const MyApp()),
      );

      //""と入力して検索する
      final formField = find.byKey(const Key('inputForm'));
      await tester.enterText(formField, '');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pump();

      //エラーが返ってくる("テキストを入力してください")
      expect(find.byKey(const Key('enterTextView')), findsOneWidget);
    });

    testWidgets('結果が0だった時に、想定の表示がされるか', (WidgetTester tester) async {
      const emptyData = RepositoryMockData.emptyJsonData;
      final mockClient = MockClient();
      //結果が0のデータを返す
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(emptyData, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
        ], child: const MyApp()),
      );

      //入力して検索する
      final formField = find.byKey(const Key('inputForm'));
      await tester.enterText(formField, 'kjsdf；ヵjdf；kぁjsdfj');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      //結果表示されるまで待つ
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      //エラーが返ってくる("検索結果が見つからない")
      expect(find.byKey(const Key('noResultView')), findsOneWidget);
    });
  });
}
