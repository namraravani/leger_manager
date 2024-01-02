import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:leger_manager/view/otp_verification_page.dart';

class LoginController extends GetxController {
  final TextEditingController mobileno = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();
  final TextEditingController EnteredOtpController = TextEditingController();
  RxString generatedOtp = ''.obs;
  void updateOtp(String newOtp) {
    generatedOtp.value = newOtp;
  }

  void sendOTP(String mob_no) async {
    String apiKey = 'bf8bd5d7-a4b9-11ee-8cbb-0200cd936042';
    String mobileno = mob_no;

    final Uri url =
        Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/$mobileno/AUTOGEN2');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('OTP')) {
        updateOtp(jsonData['OTP']);
        print(generatedOtp.value);
        Get.to(OTPVerification(
          mobileNumber: mobileno,
          generatedOtp: generatedOtp,
        ));
      } else {
        throw Exception('OTP not found in JSON response');
      }
    } else {
      throw Exception('Failed to get OTP. Status Code: ${response.statusCode}');
    }
  }

  void resendOTP(String mob_no) async {
    String apiKey = 'bf8bd5d7-a4b9-11ee-8cbb-0200cd936042';
    String mobileno = mob_no;

    final Uri url =
        Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/$mobileno/AUTOGEN2');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('OTP')) {
        updateOtp(jsonData['OTP']);
        print(jsonData['OTP']);
      } else {
        throw Exception('OTP not found in JSON response');
      }
    } else {
      throw Exception('Failed to get OTP. Status Code: ${response.statusCode}');
    }
  }

  Future<void> addMobileNumber() async {
    String mobileNumber = mobileno.text;

    if (mobileNumber.length == 10) {
      try {
        var docSnapshot = await FirebaseFirestore.instance
            .collection('shop_keeper')
            .doc(mobileNumber)
            .get();

        if (docSnapshot.exists) {
          Get.snackbar(
            'Error',
            'Mobile number already exists!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          sendOTP(mobileNumber);
          await FirebaseFirestore.instance
              .collection('shop_keeper')
              .doc(mobileNumber)
              .set({
            'mobileno': mobileNumber,
          });

          Get.snackbar(
            'Success',
            'Mobile number added!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.black,
          );
        }
      } catch (e) {
        print('Error adding mobile number to Firestore: $e');
      }
    } else {
      
      Get.snackbar(
        'Error',
        'Mobile number should be 10 digits!',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void incorrectOTP() {
    Get.snackbar(
      'OOPS',
      'Your OTP is Incorrect',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      colorText: Colors.black,
    );
  }
}
