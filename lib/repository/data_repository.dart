import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepoDataModel> getData(
      {required String repoName, required String sort, int page = 1}) async {
    // //エラーテスト用URL
    // final apiUri = Uri.parse('https://httpstat.us/429');

    final resUrl =
        'https://api.github.com/search/repositories?q=$repoName&sort=$sort&page=$page&per_page=20';

    final apiUrl = Uri.parse(Uri.encodeFull(resUrl));
    http.Response response =
        await client.get(apiUrl).timeout(const Duration(seconds: 30));

    final jsonData = json.decode(response.body);
    return RepoDataModel.fromJson(jsonData);
  }
}
