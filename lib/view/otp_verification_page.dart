import 'package:flutter/material.dart';
 
class OTPVerification extends StatelessWidget {
  final String phoneNumber;
  const OTPVerification({Key? key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
     TextEditingController otpTextController = TextEditingController();

    void verifyOTP() {
      String otpValue = otpTextController.text.trim();
      if(phoneNumber==otpValue)
      {
        print("hello");
      }
      else
      {
        print("bbye");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("addjfah"),
      ),
      body: Column(
        children: [
          TextField(
            controller: otpTextController,
          ),
          TextButton(
            onPressed: verifyOTP, // Simply call verifyOTP without ()
            child: Text("Hello"),
          ),
        ],
      ),
    );
  }
}