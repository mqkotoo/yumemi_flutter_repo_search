// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'mock_data.dart';

void main() {
  test('fromJson', () async {
    final data = json.decode(MockData.jsonData);
    final RepoDataModel result = RepoDataModel.fromJson(data);

    expect(result.totalCount, 40);
    expect(result.items.length, 1);

    expect(result.items[0].language, 'Assembly');
    expect(result.items[0].fullName, 'dtrupenn/Tetris');
  });
}
