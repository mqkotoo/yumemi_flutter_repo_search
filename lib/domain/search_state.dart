import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.uninitialized() = SearchStateUninitialized;

  const factory SearchState.loading() = SearchStateLoading;

  const factory SearchState.success({
    required List<RepoDataItems> repoData,
    required String query,
    required int page,
    required bool hasNext,
  }) = SearchStateSuccess;

  const factory SearchState.failure({
    required Exception exception,
  }) = SearchStateFail;

  const factory SearchState.fetchMoreLoading({
    required List<RepoDataItems> repoData,
    required String query,
    required int page,
  }) = SearchStateFetchMoreLoading;

  const factory SearchState.empty() = SearchStateEmpty;

  const factory SearchState.fetchMoreFailure({
    required List<RepoDataItems> repoData,
    required String query,
    required int page,
    required Exception exception,
  }) = SearchStateFetchMoreFailure;
}
