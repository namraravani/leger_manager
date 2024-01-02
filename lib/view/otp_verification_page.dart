import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/elevated_button.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/view/login_page.dart';
import 'package:leger_manager/view/master_page.dart';
import 'package:lottie/lottie.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset(
              'assets/animations/OTP_animation.json',
              height: 100,
              reverse: true,
              repeat: true,
              fit: BoxFit.cover,
            ),
            Text(
              "Enter 6 digit OTP Sent to your Number " +
                  "+91" +
                  widget.mobileNumber,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.off(LoginPage());
              },
              child: const Text(
                'Wrong Number ?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(),
                ),
                controller: loginController.EnteredOtpController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  buttonText: 'Verify',
                  onPressed: () {
                    RxString generatedOTP = widget.generatedOtp;
                    String enteredOTP =
                        loginController.EnteredOtpController.text;

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
      ),
    );
  }
}
