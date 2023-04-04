import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';

// SharedPreferences保存用キー
const _isDarkThemeKey = 'selectedThemeKey';

final themeModeProvider = StateNotifierProvider<ThemeSelector, ThemeMode>(
  ThemeSelector.new,
);

class ThemeSelector extends StateNotifier<ThemeMode> {
  ThemeSelector(this._ref) : super(ThemeMode.system) {
    // テーマが保存されていればテーマを反映、そうでなければ初期値のシステム依存
    final isDarkTheme = _prefs.getBool(_isDarkThemeKey);
    if (isDarkTheme == null) {
      return;
    }
    state = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  final Ref _ref;

  // 選択したテーマを保存するためのローカル保存領域
  late final _prefs = _ref.read(sharedPreferencesProvider);

  // テーマの変更と保存
  Future<void> toggleThemeAndSave(bool isDarkTheme) async {
    await _prefs.setBool(_isDarkThemeKey, isDarkTheme);
    state = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
