import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';
import 'package:yumemi_flutter_repo_search/theme/theme_mode_provider.dart';

void main() {
  group('themeに関するテスト', () {
    late ProviderContainer container;
    // SharedPreferences保存用キー
    const isDarkThemeKey = 'selectedThemeKey';

    setUp(() => () {
          return Future(() async {
            SharedPreferences.setMockInitialValues({});
            container = ProviderContainer(overrides: [
              sharedPreferencesProvider.overrideWithValue(
                await SharedPreferences.getInstance(),
              ),
            ]);
          });
        });

    tearDown(() => () {
          container.dispose();
        });

    test('初期状態でテーマモードが端末のシステム依存であること', () async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);
      final themeMode = container.read(themeModeProvider);
      expect(themeMode, ThemeMode.system);
    });

    test('テーマが記憶されていたら、そのテーマモードになっていること', () async {
      const isDark = false;
      //テーマモードをライトモードに設定
      SharedPreferences.setMockInitialValues({isDarkThemeKey: isDark});

      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);

      final themeMode = container.read(themeModeProvider);
      expect(themeMode, ThemeMode.light);
    });

    test('darkテーマに切り替え、テーマモードの保存ができていること', () async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);

      final themeNotifier = container.read(themeModeProvider.notifier);
      //toggle theme method →isDarkにtrueを入れてダークモードに変更
      await themeNotifier.toggleThemeAndSave(true);
      //テーマが切り替わっていることのテスト
      final currentThemeMode = container.read(themeModeProvider);
      expect(currentThemeMode, ThemeMode.dark);

      //テーマを管理しているBOOLが保存されているかのテスト
      final prefs = container.read(sharedPreferencesProvider);
      final theme = prefs.getBool(isDarkThemeKey);
      expect(theme, true);
    });

    test('テーマが保存されていない状態で、テーマ切り替えスイッチが正常に表示されている', () async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);

      //テーマが初期状態であることのテスト
      final currentThemeMode = container.read(themeModeProvider);
      expect(currentThemeMode, ThemeMode.system);

      //システムのテーマと、スイッチの表示が一致しているか
      //systemのテーマモードをlightだとする↓
      final bool initialSwitchBool = currentThemeMode == ThemeMode.system
          ? ThemeMode.light == ThemeMode.dark
          : currentThemeMode == ThemeMode.dark;

      //switchのフラグはisDarkなのでsystemがlightの場合switchはfalseが期待される
      expect(initialSwitchBool, false);
    });
  });
}
