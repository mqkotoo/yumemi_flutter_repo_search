import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';

// SharedPreferences保存用キー
const _isDarkThemeKey = 'selectedThemeKey';

//テーマ着せ替えのプロバイダー定義
final themeModeProvider = NotifierProvider<ThemeSelector, ThemeMode>(
  ThemeSelector.new,
);

class ThemeSelector extends Notifier<ThemeMode> {
  late dynamic _prefs;

  @override
  ThemeMode build() {
    //現在のテーマを取得
    _prefs = ref.read(sharedPreferencesProvider);
    // テーマが保存されていればテーマを反映、そうでなければ初期値のシステム依存
    final isDarkTheme = _prefs.getBool(_isDarkThemeKey);
    if (isDarkTheme == null) {
      return ThemeMode.system;
    }
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  // テーマの変更と保存
  Future<void> toggleThemeAndSave(bool isDarkTheme) async {
    await _prefs.setBool(_isDarkThemeKey, isDarkTheme);
    state = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
