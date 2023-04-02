import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/repo_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepoDataModel> getData(String repoName) async {
    final apiUri =
        Uri.parse('https://api.github.com/search/repositories?q=$repoName');

    http.Response response = await client.get(apiUri);

    final jsonData = json.decode(response.body);

    return RepoDataModel.fromJson(jsonData);
  }
}
