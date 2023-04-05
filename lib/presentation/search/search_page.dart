import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/controller/controllers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_count.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_list_view.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_field.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/toggle_theme_switch.dart';
import '../../generated/l10n.dart';
import '../../theme/theme_mode_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(repoDataProvider(ref.watch(inputRepoNameProvider)));

    //スイッチの初期値判定のためのシステムテーマモード取得
    final systemThemeMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
    //現在のテーマモード取得
    final themeMode = ref.watch(themeModeProvider);
    //theme切り替えのプロバイダ
    final themeSelector = ref.read(themeModeProvider.notifier);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).searchPageTitle),
              //actionsで実装すると、端っこすぎる
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
          key: const Key('searchPageAppBar'),
        ),
        body: Column(
          children: <Widget>[
            //検索フォーム
            const SearchField(),
            const Divider(),
            //結果のリストビュー
            Expanded(
              flex: 8,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // result list item
                  ResultListview(repoData: repoData),
                  // // result count
                  if (ref.watch(isResultCountVisibleProvider))
                    if (!repoData.hasError &&
                        !repoData.isLoading &&
                        repoData.value!.totalCount != 0)
                      ResultCount(resultCount: repoData.value!.totalCount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
