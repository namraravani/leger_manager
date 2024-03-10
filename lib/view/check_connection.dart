import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class CheckConnectionPage extends StatelessWidget {
  final Rx<ConnectivityResult?> _connectivityResult = Rx<ConnectivityResult?>(null);

  CheckConnectionPage() {
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _connectivityResult.value = connectivityResult;

    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar(
        'Connection Status',
        'You\'re not connected to a network',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Connection Status',
        'You\'re connected to a ${connectivityResult.name} network',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Connection Page")),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text("Check Connection Again"),
            onPressed: () async {
              await _checkConnectivity();
            },
          ),
        ),
      ),
    );
  }
}