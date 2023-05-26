// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/view/screen/home_screen.dart';
import '../infra/auth_infra.dart';

class AuthController extends GetxController {
  RxBool isAuthLoading = false.obs;
  void userAuthentication(BuildContext context) async {
    isAuthLoading.value = true;
    if (await AuthInfra.checkBiometric()) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
      isAuthLoading.value = false;
    } else {
      isAuthLoading.value = false;
    }
  }
}
