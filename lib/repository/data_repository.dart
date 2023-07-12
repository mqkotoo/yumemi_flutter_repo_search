import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../domain/error.dart';
import '../domain/repo_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepoDataModel> getData(
      {required String repoName, required String sort, int page = 1}) async {
    // try {
    // //エラーテスト用URL
    // final apiUri = Uri.parse('https://httpstat.us/403');

    final resUrl =
        'https://api.github.com/search/repositories?q=$repoName&sort=$sort&page=$page&per_page=20';

    final apiUrl = Uri.parse(Uri.encodeFull(resUrl));

    http.Response response = await client.get(apiUrl);

    // if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return RepoDataModel.fromJson(jsonData);
    //   } else {
    //     throw UnknownException();
    //   }
    // } on SocketException catch (_) {
    //   throw NoInternetException();
    // }
  }
}
