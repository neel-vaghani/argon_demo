import 'package:argon_demo/module/home/controller/home_controller.dart';
import 'package:argon_demo/module/home/infra/home_infra.dart';
import 'package:get/get.dart';

import '../../../core/connectivity/network_controller.dart';

final kHomeController = Get.put(HomeController());
final kHomeInfra = HomeInfra();
final kNetworkController = Get.put(NetworkController());
