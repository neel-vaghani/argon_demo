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
    listController.addListener(() {
      if (listController.position.maxScrollExtent ==
          listController.position.pixels) {
        kHomeController.getRepoData(
          context: context,
        );
      }
    });
  }

  @override
  void initState() {
    // GET FIRST TIME DATA
    kHomeController.getRepoData(context: context, showMainLoader: true);
    controllerListener();

    // CONNECTIVITY
    kNetworkController.connectionState.listen((event) async {
      if (event == NetworkConnectionState.disconnected) {
        await showDialog(
          context: context,
          builder: (context) {
            dialogContext = context;
            return NoInternetConnectionDialog(
              event: event,
            );
          },
        );
      } else {
        if (dialogContext != null) {
          Navigator.of(dialogContext!).pop();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text("Jake's Git"),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await kHomeController.getRepoData(
        //             context: context, showMainLoader: true);
        //       },
        //       icon: Icon(Icons.abc))
        // ],
      ),
      body: Obx(
        () => kHomeController.mainLoader.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
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
