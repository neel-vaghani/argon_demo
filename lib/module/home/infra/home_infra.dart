import 'dart:convert';
import 'dart:developer';

import 'package:argon_demo/core/dbService/db_string_const.dart';
import 'package:argon_demo/core/dioService/api_dio.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/dbService/db.dart';
import '../../../core/dioService/api_string_const.dart';
import '../../../core/dioService/dio_exception.dart';
import '../model/git_repo_model.dart';

class HomeInfra {
  final DB _db = DB();

  // GET DATA FROM API
  Future<Either<List<GitRepoModel>, String>> getGitRepoListFromAPI(
      {required int pageNo}) async {
    try {
      final response = await ApiDio.instant.get(
        ApiStringConst.GET_USER_REPO,
        queryParameters: {"page": pageNo, "per_page": 10},
      );
      return Left(gitRepoModelFromJson(
        jsonEncode(response.data),
      ));
    } on DioExceptions catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      return right(e.toString());
    }
  }

  // GET DATE FROM DATABASE
  Future<List<GitRepoModel>> getGitRepoListFromDB() async {
    try {
      var maps = await _db.query(DbStringConst.REPO_TABLE_NAME);
      List<GitRepoModel> allRepoList = [];
      for (var element in maps) {
        allRepoList.add(GitRepoModel.fromJson(element));
      }
      return allRepoList;
    } on DioExceptions catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      return [];
    }
  }

  // ADD DATA INTO DATABASE
  Future<void> insertDataIntoDatabase({
    required List<GitRepoModel> repoList,
  }) async {
    for (var data in repoList) {
      await _db.insert(
        DbStringConst.REPO_TABLE_NAME,
        data.toJson(),
      );
    }
  }
}
