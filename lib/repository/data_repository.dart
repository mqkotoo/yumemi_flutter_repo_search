import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../domain/repo_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepoDataModel> getData(String repoName) async {
    try {
      // //エラーテスト用URL
      // final apiUri = Uri.parse('https://httpstat.us/403');

      final apiUri =
          Uri.parse('https://api.github.com/search/repositories?q=$repoName');
      http.Response response = await client.get(apiUri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RepoDataModel.fromJson(jsonData);
      } else {
        throw 'Error Occurred';
      }
    } on SocketException catch (_) {
      throw 'Network Error';
    }
  }
}
