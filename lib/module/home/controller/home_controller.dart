import 'package:argon_demo/core/storageHelper/storage_helper.dart';
import 'package:argon_demo/module/home/infra/home_infra.dart';
import 'package:argon_demo/module/home/model/git_repo_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dependencies/home_dependencies.dart';

class HomeController extends GetxController {
  RxBool mainLoader = false.obs;
  RxList<GitRepoModel> repoList = <GitRepoModel>[].obs;
  int pageCount = 1;

  Future<void> getRepoData({
    required BuildContext context,
    bool? showMainLoader,
  }) async {
    mainLoader.value = showMainLoader ?? false;
    Either<List<GitRepoModel>, String> result =
        await kHomeInfra.getGitRepoListFromAPI(
      pageNo: pageCount,
    );
    result.fold((success) async {
      if (pageCount > (StorageHelper.getPageNumber() ?? 0)) {}
      // PAGE COUNT UPDATE
      await StorageHelper.setPageNumber(
        pageNumber: pageCount,
      );
      // STORE CURRENT PAGE DATA IN DATABASE
      await kHomeInfra.insertDataIntoDatabase(repoList: success);
      // PAGE COUNT UPDATE
      pageCount++;
      repoList.addAll(success);
    }, (fail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(fail),
        ),
      );
    });
    mainLoader.value = false;
  }
}
