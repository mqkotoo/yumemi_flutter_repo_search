import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/controller/controllers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_count.dart';
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
    //テキストのコントローラ
    final textController = ref.watch(textEditingControllerProvider);

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              //search field
              child: TextFormField(
                controller: textController,
                onChanged: (text) {
                  ref
                      .read(isClearButtonVisibleProvider.notifier)
                      .update((state) => text.isNotEmpty);
                },
                //入力キーボードのdone→searchに変更
                textInputAction: TextInputAction.search,
                //search押したらデータ取得 データ渡す
                onFieldSubmitted: (text) {
                  //無駄な余白をカットしてプロバイダーに渡す
                  ref
                      .read(inputRepoNameProvider.notifier)
                      .update((state) => text.trim());
                },
                //decoration
                decoration: InputDecoration(
                  hintText: S.of(context).formHintText,
                  prefixIcon: const Icon(Icons.search, size: 27),
                  suffixIcon: ref.watch(isClearButtonVisibleProvider)
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 27),
                          onPressed: () {
                            textController.clear();
                            ref
                                .watch(isClearButtonVisibleProvider.notifier)
                                .update((state) => false);
                          },
                          key: const Key('clearButton'),
                        )
                      : const SizedBox.shrink(),
                ),
                key: const Key('inputForm'),
              ),
            ),
            const Divider(),
            Expanded(
              flex: 8,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // result list item
                  repoData.when(
                    data: (data) => data.totalCount == 0
                        //検索結果がない場合
                        ? const NoResultView()
                        //検索結果がある場合
                        //スクロールを検知して、スクロール中は検索結果数を表示しないようにする
                        : NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollStartNotification) {
                                // スクロールが開始された場合の処理(非表示)
                                ref
                                    .read(isResultCountVisibleProvider.notifier)
                                    .update((state) => false);
                              } else if (notification
                                  is ScrollEndNotification) {
                                // スクロールが終了した場合の処理(表示)
                                ref
                                    .read(isResultCountVisibleProvider.notifier)
                                    .update((state) => true);
                              }
                              return true;
                            },
                            child: ListView.separated(
                              //スクロールでキーボードを閉じるようにした
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: data.items.length,
                              itemBuilder: (context, index) => ListItem(
                                repoData: data.items[index],
                                userIconUrl: data.items[index].owner.avatarUrl,
                                fullName: data.items[index].fullName,
                                description: data.items[index].description,
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Color(0xffBBBBBB),
                              ),
                            ),
                          ),
                    error: (e, _) {
                      switch (e) {
                        case 'No Keywords':
                          return const EnterTextView();
                        case 'Network Error':
                          return const NetworkErrorView();
                        case 'Error Occurred':
                          return const ErrorView();
                        default:
                          throw Exception(e);
                      }
                    },
                    loading: () => const ListItemShimmer(),
                  ),

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
