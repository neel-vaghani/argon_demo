// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:argon_demo/core/storageHelper/storage_helper.dart';
import 'package:argon_demo/module/home/infra/home_infra.dart';
import 'package:argon_demo/module/home/model/git_repo_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/dbService/db.dart';
import '../../../utils/enum/common_enum.dart';
import '../dependencies/home_dependencies.dart';

class HomeController extends GetxController {
  RxBool mainLoader = false.obs;
  RxList<GitRepoModel> repoList = <GitRepoModel>[].obs;
  int pageCount = 1;

  // GET REPO DATA
  Future<void> getRepoData({
    required BuildContext context,
    bool? showMainLoader,
    required DataSource dataSource,
  }) async {
    mainLoader.value = showMainLoader ?? false;

    switch (dataSource) {
      case DataSource.api:
        Either<List<GitRepoModel>, String> result =
            await kHomeInfra.getGitRepoListFromAPI(
          pageNo: pageCount,
        );
        result.fold((success) async {
          if (pageCount > (StorageHelper.getPageNumber() ?? 0)) {
            // PAGE COUNT UPDATE
            await StorageHelper.setPageNumber(
              pageNumber: pageCount,
            );
            log(name: "F In", StorageHelper.getPageNumber().toString());
            // STORE CURRENT PAGE DATA IN DATABASE
            await kHomeInfra.insertDataIntoDatabase(repoList: success);
          }

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
        break;
      case DataSource.dataBase:
        repoList.value = await kHomeInfra.getGitRepoListFromDB();
        break;
    }

    mainLoader.value = false;
  }

  // RESET EVERY THING
  Future<void> resetEveryThing(BuildContext context) async {
    await StorageHelper.setPageNumber(pageNumber: 0);
    await DB().deleteEverything();
    pageCount = 1;
    kHomeController.repoList.clear();
    await getRepoData(
      context: context,
      showMainLoader: true,
      dataSource: kNetworkController.connectionState.value ==
              NetworkConnectionState.connected
          ? DataSource.api
          : DataSource.dataBase,
    );
  }
}
