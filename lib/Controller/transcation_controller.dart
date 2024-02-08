import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:http/http.dart' as http;

class TranscationController extends GetxController {
  RxList<Transcation> transcationlist = <Transcation>[].obs;
  TextEditingController data = TextEditingController();
  TextEditingController variable = TextEditingController();
  RxString mobileNumber = ''.obs;
  RxString contactinfo = ''.obs;

  void setMobileNumber(String number) {
    mobileNumber.value = number;
  }

  String _customerInfo = '';

  void setCustomerInfo(String customerInfo) {
    _customerInfo = customerInfo;
  }

  String get customerInfo => _customerInfo;

  Future<int> getShopId(String yourStringData) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getshopid';

    try {
      print(yourStringData);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contactinfo": yourStringData,
          // Add more key-value pairs as needed
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        int shopId = responseData['shopId'];
        print(shopId);
        return shopId;
      } else {
        throw Exception(
            'Failed to get shopId. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<int> getCustomerID(String yourStringData) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchcustomerid';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contactinfo": yourStringData,
          // Add more key-value pairs as needed
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        int shopId = responseData['customerId'];
        return shopId;
      } else {
        throw Exception(
            'Failed to get shopId. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void postTranscation(
      String shopid, String customer_id, num amt, String type) async {
    print("Post customer method is called");
    try {
      
      if (shopid.isEmpty || customer_id.isEmpty || type.isEmpty) {
        print("Empty Data");
        return;
      }
      // num a = 5;
      
      Map<String, dynamic> customerData = {
        'customerid': customer_id,
        'amount': amt,
        'type':type,
        'shopid': shopid,
      };

      print("data added in map");

      String jsonData = json.encode(customerData);

      print("hello json encoded");

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/createtranscation'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );
      print(jsonData);
      if (response.statusCode == 200) {
        print("data added in trnascation Sucessfully");

        // print('Customer added successfully');
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
