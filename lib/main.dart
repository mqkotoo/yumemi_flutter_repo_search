import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/search_page.dart';
import 'package:yumemi_flutter_repo_search/repository/data_repository.dart';
import 'package:yumemi_flutter_repo_search/repository/http_client.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';
import 'package:yumemi_flutter_repo_search/theme/theme.dart';

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return DataRepository(client: ref.watch(httpClientProvider));
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        //インスタンス取得は非同期なので初回に取得してキャッシュしておく
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const SearchPage(),
    );
  }
}
