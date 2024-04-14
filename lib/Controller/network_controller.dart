import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void updateConnectionStatus(ConnectivityResult connectivityresult) {
    if (connectivityresult == ConnectivityResult.none) {
      isConnected.value == false;
      update();
      print("Connection not done");
    } else {
      isConnected.value = true;
      update();
      print("Connection secure");
    }
  }
}
