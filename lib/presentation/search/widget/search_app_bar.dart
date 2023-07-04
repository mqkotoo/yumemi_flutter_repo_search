import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/toggle_theme_switch.dart';
import '../../../generated/l10n.dart';
import '../../../theme/theme_mode_provider.dart';

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @visibleForTesting
  static final searchPageAppBarKey = UniqueKey();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //スイッチの初期値判定のためのシステムテーマモード取得
    final systemThemeMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
    //現在のテーマモード取得
    final themeMode = ref.watch(themeModeProvider);
    //theme切り替えのプロバイダ
    final themeSelector = ref.read(themeModeProvider.notifier);
    return AppBar(
      key: searchPageAppBarKey,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            S.of(context).searchPageTitle,
          ),
          ToggleThemeSwitch(
            //themeModeが初期（SYSTEM）状態だったらその情報を使って表示を処理する
            value: themeMode == ThemeMode.system
                ? systemThemeMode == ThemeMode.dark
                : themeMode == ThemeMode.dark,
            onToggle: (value) {
              themeSelector.toggleThemeAndSave(value);
            },
          ),
        ],
      ),
    );
  }
}
