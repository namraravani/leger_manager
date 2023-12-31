import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';

class LoginController extends GetxController {
  final TextEditingController mobileno = TextEditingController();

  Future<void> addMobileNumber() async {
    try {
      String mobileNumber = mobileno.text;

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
  }
}
