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
    String apiKey = '872b4901-c1d0-11ee-8cbb-0200cd936042';
    String mobileno = mob_no;

    final Uri url =
        Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/$mobileno/AUTOGEN2');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('OTP')) {
        updateOtp(jsonData['OTP']);
        print(generatedOtp.value);
        Get.off(OTPVerification(
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

  void postCustomer(String phonenumber) async {
    try {
      if (phonenumber.isEmpty) {
        return;
      }

      Map<String, dynamic> customerData = {
        'contactinfo': phonenumber,
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertshop'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Shopkeeper added successfully');
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> addMobileNumber() async {
    String mobileNumber = mobileno.text;

    postCustomer(mobileNumber);
    sendOTP(mobileNumber);
    Get.to(OTPVerification(
        generatedOtp: generatedOtp, mobileNumber: mobileNumber));
  }
}
