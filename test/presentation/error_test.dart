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
      when(mockClient.get(any)).thenAnswer((_) async =>
          http.Response(data, 200));

      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
        ], child: const MyApp()),
      );

      final formField = find.byKey(const Key('inputForm'));

      //""と入力して検索する
      await tester.enterText(formField, '');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pump();

      //エラーが返ってくる("テキストを入力してください")
      expect(find.byKey(const Key('enterTextView')), findsOneWidget);
    });
  });
}
