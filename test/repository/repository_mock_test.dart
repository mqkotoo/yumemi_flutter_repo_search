import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import '../repository/repository_mock_data.dart';
import 'repository_mock_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('repository test', () {
    //mock data
    const data = RepositoryMockData.jsonData;

    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    late ProviderContainer container;

    setUp(() {
      //mockのhttpクライアントでDIする
      container = ProviderContainer(
        overrides: [httpClientProvider.overrideWithValue(mockClient)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('getメソッドのテスト', () async {
      //上でオーバーライドされたmockのHTTPクライアントのインスタンスをみれてる
      final result = await container
          .read(dataRepositoryProvider)
          .getData(repoName: 'flutter', sort: 'bestmatch');

      expect(result,
          RepoDataModel.fromJson(jsonDecode(data) as Map<String, dynamic>));
    });
  });
}
