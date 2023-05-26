import 'dart:convert';
import 'dart:developer';

import 'package:argon_demo/core/dioService/api_dio.dart';
import 'package:dartz/dartz.dart';

import '../../../core/dioService/api_string_const.dart';
import '../../../core/dioService/dio_exception.dart';
import '../model/git_repo_model.dart';

abstract class HomeInfra {
  static Future<Either<List<GitRepoModel>, String>> getGitRepoListFromAPI(
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
}
