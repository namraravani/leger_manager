import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';

class CustomerController extends GetxController {
  RxList<Customer> customerlist = <Customer>[].obs;
  TextEditingController customername = TextEditingController();
  TextEditingController customerinfo = TextEditingController();

  @override
  void onInit() {
    getCustomer();
    super.onInit();
  }

  Future<void> postCustomer() async {
    try {
      if (customername.text.isEmpty || customerinfo.text.isEmpty) {
        print("Hello I AM HERE Thats why it's not working");
        return;
      }

      Map<String, dynamic> customerData = {
        'name': customername.text,
        'contactinfo': customerinfo.text,
        'type': 1
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertCustomer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print("Customer Added Namra Ravani dont woory");
        await getCustomer();
        print('Customer added successfully');
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void postCustomerFromContact(String name, String Phonenumber) async {
    print("Post customer method is called");
    try {
      print("Post customer herlloo");
      if (name.isEmpty || Phonenumber.isEmpty) {
        print("Post customer Hiiiiiii");
        return;
      }

      Map<String, dynamic> customerData = {
        'name': name,
        'contactinfo': Phonenumber,
        'type': 1
      };

      print("data added in map");

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertCustomer'), // Replace with your actual API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print("data added in database from Contact Sucessfully");
        getCustomer();
        print('Customer added successfully');
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getCustomer() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getcustomers'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> customerData = json.decode(response.body);

        List<Customer> customers =
            customerData.map((data) => Customer.fromJson(data)).toList();

        customerlist.assignAll(customers);
        update();

        for (int i = 0; i < customerlist.length; i++) {
          print(
              customerlist[i].customerName + ' ' + customerlist[i].contactInfo);
        }

        // You might want to update the UI or perform other actions here
      } else {
        // Handle error response
        print('Error fetching customers: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions
      print('Error: $error');
    }
  }
}
