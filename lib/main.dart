import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/storageHelper/storage_helper.dart';
import 'module/auth/view/screen/auth_screen.dart';
import 'module/home/view/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
