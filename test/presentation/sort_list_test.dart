import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/presentation/provider/providers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';
import 'package:yumemi_flutter_repo_search/theme/shared_preferences_provider.dart';

void main() {
  testWidgets('ソートボタンの動作テスト', (WidgetTester tester) async {
    //モックのデータをshared_preferencesにセットしておかないといけない
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ], child: const MyApp()),
    );

    //sortボタンがあるか
    final sortButton = find.byKey(SearchBar.sortButtonKey);
    expect(sortButton, findsOneWidget);

    //ソートボタンをタップする
    await tester.tap(sortButton);

    await tester.pump();

    // 4つの選択肢が表示されているはず(英語になっているようなので英語テキストでテストをする)
    expect(find.text('Best Match'), findsOneWidget);
    expect(find.text('Updated'), findsOneWidget);
    expect(find.text('Stars'), findsOneWidget);
    expect(find.text('Forks'), findsOneWidget);
    expect(find.text('Help Wanted Issues'), findsOneWidget);

    // BuildContextを取得
    final BuildContext context = tester
        .element(find.byWidgetPredicate((Widget widget) => widget is MyApp));

    // ProviderContainerを取得
    final container = ProviderScope.containerOf(context);

    // sortStringProviderの現在の値を取得する
    final selectedValue = container.read(sortStringProvider);

    // 初期値のソートの値はベストマッチ
    expect(selectedValue, 'bestmatch');

    //スター順に変更（タップ）
    await tester.tap(find.text('Stars'));
    //描画を待つ
    await tester.pump();

    //ソートメニューは閉じられているはず
    expect(find.text('Best Match'), findsNothing);
    expect(find.text('Updated'), findsNothing);
    expect(find.text('Stars'), findsNothing);
    expect(find.text('Forks'), findsNothing);
    expect(find.text('Help Wanted Issues'), findsNothing);

    // sortStringProviderの新しい値を取得する
    final newSelectedValue = container.read(sortStringProvider);

    // スター順に変更されているはず
    expect(newSelectedValue, 'stars');
  });
}
