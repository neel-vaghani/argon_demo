// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:argon_demo/core/dbService/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidget/no_internet_connection_dialog.dart';
import '../../../../utils/enum/common_enum.dart';
import '../../dependencies/home_dependencies.dart';
import '../../model/git_repo_model.dart';
import '../widget/repo_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController listController = ScrollController();
  BuildContext? dialogContext;
  // CONTROLLER LISTENER
  controllerListener() async {
    listController.addListener(() async {
      if (listController.position.maxScrollExtent ==
          listController.position.pixels) {
        log(1.toString());
        await kHomeController.getRepoData(
          dataSource: kNetworkController.connectionState.value ==
                  NetworkConnectionState.connected
              ? DataSource.api
              : DataSource.dataBase,
          context: context,
        );
      }
    });
  }

  @override
  void initState() {
    // CONNECTIVITY .
    kNetworkController.connectionState.listen((event) async {
      if (event == NetworkConnectionState.disconnected) {
        log(2.toString());
        kHomeController.getRepoData(
            dataSource: event == NetworkConnectionState.connected
                ? DataSource.api
                : DataSource.dataBase,
            context: context,
            showMainLoader: true);
        await showDialog(
          context: context,
          builder: (context) {
            dialogContext = context;
            return NoInternetConnectionDialog(
              event: event,
            );
          },
        );
        dialogContext = null;
      } else {
        kHomeController.repoList.clear();
        kHomeController.pageCount = 1;
        log(3.toString());

        kHomeController.getRepoData(
            dataSource: event == NetworkConnectionState.connected
                ? DataSource.api
                : DataSource.dataBase,
            context: context,
            showMainLoader: true);
        if (dialogContext != null) {
          Navigator.of(dialogContext!).pop();
        }
      }
    });

    // PAGINATION .
    controllerListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text("Jake's Git"),
        actions: [
          Center(
              child: Obx(
            () => Text(
              kNetworkController.connectionState.value ==
                      NetworkConnectionState.connected
                  ? "Api Data"
                  : "Database Data",
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          )),
          IconButton(
              onPressed: () async {
                await kHomeController.resetEveryThing(context);
              },
              // ignore: prefer_const_constructors
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Obx(
        () => kHomeController.mainLoader.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : kHomeController.repoList.isEmpty
                ? const Center(child: Text("No Data Available"))
                : ListView.builder(
                    controller: listController,
                    itemCount: kHomeController.repoList.length,
                    itemBuilder: (context, index) {
                      GitRepoModel repoData = kHomeController.repoList[index];
                      return RepoListTile(
                        index: index,
                        repoData: repoData,
                      );
                    },
                  ),
      ),
    );
  }
}
