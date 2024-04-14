import 'package:get/get.dart';
import 'package:leger_manager/Controller/network_controller.dart';

class Dependencyinjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
