import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/repository/data_repository.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import 'package:yumemi_flutter_repo_search/search_page.dart';

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return DataRepository(client: ref.watch(httpClientProvider));
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchPage(),
    );
  }
}
