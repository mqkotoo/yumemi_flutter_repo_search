import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/main.dart';

import '../../domain/repo_data_model.dart';
import '../../domain/search_state.dart';
import '../../repository/data_repository.dart';
import '../provider/providers.dart';

final searchStateNotifierProvider =
    StateNotifierProvider.autoDispose<SearchStateNotifier, SearchState>(
        (ref) => SearchStateNotifier(ref));

class SearchStateNotifier extends StateNotifier<SearchState> {
  SearchStateNotifier(this._ref) : super(const SearchState.uninitialized());

  final Ref _ref;

  DataRepository get _searchApi => _ref.watch(dataRepositoryProvider);

  //sort
  String get _sortString => _ref.watch(sortStringProvider);

  Future<void> searchRepositories(String query) async {
    if (state is SearchStateSearching) {
      return;
    }

    //検索ワードがなかったらエラーを返す
    if (query.isEmpty) {
      state = SearchState.failure(exception: NoTextException());
      return;
    }

    state = const SearchState.searching();

    const page = 1;
    final RepoDataModel result;
    try {
      result = await _searchApi.getData(repoName: query, sort: _sortString);
    } on SocketException {
      state = SearchState.failure(exception: NoInternetException());
      return;
    } catch (_) {
      state = SearchState.failure(exception: UnknownException());
      return;
    }

    if (result.items.isEmpty) {
      state = const SearchState.empty();
      return;
    }

    state = SearchState.success(
      repoData: result.items,
      query: query,
      page: page,
      hasNext: result.hasNext,
    );
  }

  Future<void> fetchNext() async {
    if (state is SearchStateSearching || state is SearchStateFetchingNext) {
      return;
    }

    final currentState = state.maybeMap(
      success: (value) => value,
      orElse: () {
        AssertionError();
      },
    )!;

    final query = currentState.query;
    final page = currentState.page + 1;
    state = SearchState.fetchingNext(
      repoData: currentState.repoData,
      query: query,
      page: page,
    );

    final RepoDataModel result;
    try {
      result = await _searchApi.getData(
          repoName: query, sort: _sortString, page: page);
    } on Exception catch (_) {
      state = SearchState.success(
        repoData: currentState.repoData,
        query: query,
        page: page,
        hasNext: false,
      );
      return;
    }

    state = SearchState.success(
      repoData: currentState.repoData + result.repositories,
      query: query,
      page: page,
      hasNext: result.hasNext,
    );
  }
}

extension Pagination on RepoDataModel {
  bool get hasNext => totalCount > items.length;

  List<RepoDataItems> get repositories => items
      .map((repo) => RepoDataItems(
            fullName: repo.fullName,
            description: repo.description,
            language: repo.language,
            stargazersCount: repo.stargazersCount,
            watchersCount: repo.watchersCount,
            forksCount: repo.forksCount,
            openIssuesCount: repo.openIssuesCount,
            htmlUrl: repo.htmlUrl,
            owner: repo.owner,
          ))
      .toList();
}
