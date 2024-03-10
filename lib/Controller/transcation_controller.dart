import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:http/http.dart' as http;
import 'package:leger_manager/Controller/customer_controller.dart';

class TranscationController extends GetxController {
  RxList<Transcation> transcationlist = <Transcation>[].obs;
  TextEditingController data = TextEditingController();
  TextEditingController variable = TextEditingController();
  RxString mobileNumber = ''.obs;
  RxString contactinfo = ''.obs;

  final CustomerController customerController = Get.put(CustomerController());

  @override
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

  String formatTime(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);

      String formattedTime = DateFormat('h:mm a').format(originalTime);

      return formattedTime;
    } catch (e) {
      return "Invalid Time";
    }
  }

  String formatDate(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);
      String formattedDate = DateFormat('yyyy-MM-dd').format(originalTime);
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "Invalid Date";
    }
  }

  DateTime DisplayDay(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);
      // String formattedDate = DateFormat('yyyy-MM-dd').format(originalTime);
      return originalTime;
    } catch (e) {
      print("Error formatting date: $e");
      return DateTime.now();
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
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        int customer_id = responseData['customerId'];

        return customer_id;
      } else {
        throw Exception(
            'Failed to get customer id. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> maintainRelation(int shop_id, int customerid) async {
    try {
      // Replace with your actual value
      // int customer_id = await getCustomerID(_customerInfo);

      Map<String, dynamic> customerData = {
        "custid": customerid,
        "shop_id": shop_id,
      };

      String jsonData = json.encode(customerData);

      // print("Hello I am heree this i s afa Shop Id" + "${shop_id}");

      const apiUrl =
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertRelation';

      final response = await http.post(Uri.parse(apiUrl), body: jsonData);

      if (response.statusCode == 200) {
        print('Relation inserted successfully: ${response.body}');
      } else {
        print(
            'Error while ajgnsjgndgjdsngsdjnsdkjfnk inserting relation: ${response.statusCode}');
      }
    } catch (error) {}
  }

  void postTranscation(
      String shopid, String customer_id, num amt, String type) async {
    try {
      if (shopid.isEmpty || customer_id.isEmpty || type.isEmpty) {
        print("Empty Data");
        return;
      }

      Map<String, dynamic> customerData = {
        'customerid': customer_id,
        'amount': amt,
        'type': type,
        'shopid': shopid,
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/createtranscation'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );
      print(jsonData);
      if (response.statusCode == 200) {
        int intValue1 = int.parse(shopid);
        int intValue2 = int.parse(customer_id);
        getAlltranscation(intValue1, intValue2);
        print("data added in trnascation Sucessfully");
        customerController.updateData();
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void getAlltranscation(int shopid, int customer_id) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/gettranscationbyid';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "custid": customer_id,
          "shop_id": shopid,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        List<Transcation> transcationList = jsonData
            .map((transaction) => Transcation.fromJson(transaction))
            .toList();

        transcationlist.assignAll(transcationList);

        for (int i = 0; i < transcationList.length; i++) {
          print(transcationList[i].itemsList);
        }
      } else {
        print(
            "Failed to get transactions. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
      // Handle other exceptions here
    }
  }
}
