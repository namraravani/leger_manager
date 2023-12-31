import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Controller/login_controller.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("addjfah"),
      ),
      body: Column(
        children: [
          TextField(
            controller: loginController.otpcontroller,
          ),

          TextButton(onPressed: (){
            
          }, child: Text("Herllo")),
        ],
      ),
    );
  }
}
