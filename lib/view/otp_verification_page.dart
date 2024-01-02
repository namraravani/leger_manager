import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/elevated_button.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/view/master_page.dart';
import 'package:pinput/pinput.dart';

class OTPVerification extends StatefulWidget {
  final RxString generatedOtp;
  final String mobileNumber;

  const OTPVerification(
      {Key? key, required this.generatedOtp, required this.mobileNumber})
      : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  late List<TextEditingController> controllers;
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        height: 55,
        width: 55,
        textStyle: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.secondaryColor),
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter OTP"),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(),
                ),
                controller: loginController.EnteredOtpController,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                buttonText: 'Verify',
                onPressed: () {
                  RxString generatedOTP = widget.generatedOtp;
                  String enteredOTP = loginController.EnteredOtpController.text;

                  if (enteredOTP == generatedOTP.value) {
                    Get.off(MasterPage());
                  } else {
                    loginController.incorrectOTP();
                  }
                },
              ),
              CustomButton(
                buttonText: 'Resend OTP',
                onPressed: () {
                  loginController.resendOTP(widget.mobileNumber);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
