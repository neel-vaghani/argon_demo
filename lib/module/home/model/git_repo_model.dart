// To parse this JSON data, do
//
//     final gitRepoModel = gitRepoModelFromJson(jsonString);

import 'dart:convert';

import '../../../core/dbService/db_string_const.dart';

List<GitRepoModel> gitRepoModelFromJson(String str) => List<GitRepoModel>.from(
    json.decode(str).map((x) => GitRepoModel.fromJson(x)));

String gitRepoModelToJson(List<GitRepoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GitRepoModel {
  final String? name;
  final String? description;
  final int? watchersCount;
  final String? language;
  final int? openIssuesCount;

  GitRepoModel({
    this.name,
    this.description,
    this.openIssuesCount,
    this.watchersCount,
    this.language,
  });

  factory GitRepoModel.fromJson(Map<String, dynamic> json) => GitRepoModel(
        name: json[DbStringConst.REPO_NAME],
        description: json[DbStringConst.REPO_DESCRIPTION],
        watchersCount: json[DbStringConst.REPO_WATCHERS_COUNT],
        language: json[DbStringConst.REPO_LANGUAGE],
        openIssuesCount: json[DbStringConst.REPO_OPEN_ISSUE],
      );

  Map<String, dynamic> toJson() => {
        DbStringConst.REPO_NAME: name,
        DbStringConst.REPO_DESCRIPTION: description,
        DbStringConst.REPO_WATCHERS_COUNT: watchersCount,
        DbStringConst.REPO_LANGUAGE: language,
        DbStringConst.REPO_OPEN_ISSUE: openIssuesCount,
      };
}
