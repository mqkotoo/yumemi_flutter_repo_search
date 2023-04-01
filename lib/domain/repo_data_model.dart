// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_data_model.freezed.dart';
part 'repo_data_model.g.dart';

@freezed
class RepoDataModel with _$RepoDataModel {
  const factory RepoDataModel({
    required int totalCount,
    required List<RepoDataItems> items,
  }) = _RepoDataModel;

  factory RepoDataModel.fromJson(Map<String, dynamic> json) =>
      _$RepoDataModelFromJson(json);
}

@freezed
class RepoDataItems with _$RepoDataItems {
  const factory RepoDataItems({
    required String fullName,
    required String? description,
    required String? language,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
    required RepoDataOwner owner,
  }) = _RepoDataItems;

  factory RepoDataItems.fromJson(Map<String, dynamic> json) =>
      _$RepoDataItemsFromJson(json);
}

@freezed
class RepoDataOwner with _$RepoDataOwner {
  const factory RepoDataOwner({
    required String avatarUrl,
  }) = _RepoDataOwner;

  factory RepoDataOwner.fromJson(Map<String, dynamic> json) =>
      _$RepoDataOwnerFromJson(json);
}
