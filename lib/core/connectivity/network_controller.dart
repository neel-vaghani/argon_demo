// ignore_for_file: must_call_super

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/enum/common_enum.dart';

class NetworkController extends GetxController {
  // RxInt connectionType = 0.obs;
  Rx<NetworkConnectionState> connectionState =
      Rx(NetworkConnectionState.disconnected);
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connectionState.value = NetworkConnectionState.connected;
        update();
        break;
      case ConnectivityResult.none:
        connectionState.value = NetworkConnectionState.disconnected;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
