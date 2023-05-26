// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:argon_demo/module/auth/infra/auth_infra.dart';
import 'package:argon_demo/module/home/view/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dependencies/auth_dependencies.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    kAuthController.userAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                "Auth",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => kAuthController.isAuthLoading.value
                  ? CupertinoActivityIndicator()
                  : IconButton(
                      onPressed: () async {
                        kAuthController.userAuthentication(context);
                      },
                      icon: const Icon(
                        Icons.fingerprint_outlined,
                        size: 50,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
