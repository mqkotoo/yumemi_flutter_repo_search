import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/generated/l10n.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_page.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';

void main() {
  group('多言語対応が適応されて表示されているか', () {
    Widget myTestWidget(Locale locale) {
      return MaterialApp(
        //多言語対応
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: locale,
        home: const SearchPage(),
      );
    }

    testWidgets('多言語対応のテスト 英語', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      //英語でアプリ起動
      await tester.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: myTestWidget(const Locale('en')),
      ));

      //描画を待つ
      await tester.pump();

      // 英語のテスト
      expect(find.text('GitHub Search'), findsOneWidget);
      expect(find.text('GitHubサーチ'), findsNothing);
    });

    testWidgets('多言語対応のテスト 日本語', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      //日本語でアプリ起動
      await tester.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: myTestWidget(const Locale('ja')),
      ));

      //描画するまで待つ
      await tester.pump();

      // 日本語のテスト
      expect(find.text('GitHubサーチ'), findsOneWidget);
      expect(find.text('GitHub Search'), findsNothing);
    });
  });
}
