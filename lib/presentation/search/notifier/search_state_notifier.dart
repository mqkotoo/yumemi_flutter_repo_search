import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'package:yumemi_flutter_repo_search/domain/search_state.dart';
import 'package:yumemi_flutter_repo_search/main.dart';
import 'package:yumemi_flutter_repo_search/presentation/provider/providers.dart';
import 'package:yumemi_flutter_repo_search/repository/data_repository.dart';

final searchStateNotifierProvider =
    NotifierProvider.autoDispose<SearchStateNotifier, SearchState>(
  SearchStateNotifier.new,
);

class SearchStateNotifier extends AutoDisposeNotifier<SearchState> {
  DataRepository get _searchApi => ref.read(dataRepositoryProvider);

  @override
  SearchState build() => const SearchState.uninitialized();

  Future<void> searchRepositories(String query, String sortString) async {
    if (state is SearchStateLoading) {
      return;
    }

    //検索ワードがなかったらエラーを返す
    if (query.isEmpty) {
      state = SearchState.failure(exception: NoTextException());
      return;
    }

    state = const SearchState.loading();

    const page = 1;
    final RepoDataModel result;
    try {
      result = await _searchApi.getData(repoName: query, sort: sortString);
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

  Future<void> fetchMore() async {
    if (state is SearchStateLoading || state is SearchStateFetchMoreLoading) {
      return;
    }

    state.maybeWhen(
      success: (repoData, query, page, hasNext) =>
          _fetchMore(repoData, query, page + 1),
      fetchMoreFailure: (repoData, query, page, _) =>
          _fetchMore(repoData, query, page),
      orElse: () {
        throw AssertionError();
      },
    );
  }

  Future<void> _fetchMore(
      List<RepoDataItems> repoData, String query, int page) async {
    try {
      state = SearchState.fetchMoreLoading(
          repoData: repoData, query: query, page: page);

      final result = await _searchApi.getData(
          repoName: query, sort: ref.read(sortStringProvider), page: page);

      state = SearchState.success(
        repoData: repoData + result.repositories,
        query: query,
        page: page,
        hasNext: result.items.isEmpty ? false : true,
      );
    } on SocketException {
      state = SearchState.fetchMoreFailure(
        repoData: repoData,
        query: query,
        page: page,
        exception: NoInternetException(),
      );
      return;
    } catch (e) {
      state = SearchState.fetchMoreFailure(
        repoData: repoData,
        query: query,
        page: page,
        exception: UnknownException(),
      );
    }
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
