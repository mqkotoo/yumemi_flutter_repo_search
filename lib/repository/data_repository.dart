import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../domain/repo_data_model.dart';

class DataRepository{
  Future<RepoDataModel> getData(String repositoryName) async{
    final apiUri = Uri.parse('https://api.github.com/search/repositories?q=$repositoryName&page=5');

    http.Response response = await http.get(apiUri);

    if(response.statusCode != 200) {
      if (kDebugMode) {
        print('error: ${response.statusCode}');
      }
    }

    final jsonData = json.decode(response.body);

    return RepoDataModel.fromJson(jsonData);
  }
}