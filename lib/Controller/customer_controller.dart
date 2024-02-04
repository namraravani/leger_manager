import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';

class CustomerController extends GetxController {
  RxList<Customer> customerlist = RxList<Customer>.from([]);
  TextEditingController customername = TextEditingController();
  TextEditingController customerinfo = TextEditingController();

  addCustomer() {
    if (customername.text.isNotEmpty && customerinfo.text.isNotEmpty) {
      // customerlist.add(Customer(customername.text, customerinfo.text));
      customername.clear();
      customerinfo.clear();

      print('Customer added: ${customerlist.last.customerName}');
      update();
    }
  }

  void postCustomer() async {
    try {
      
      if (customername.text.isEmpty || customerinfo.text.isEmpty) {
        
        return;
      }

      
      Map<String, dynamic> customerData = {
        'name': customername.text,
        'contactinfo': customerinfo.text,
      };

      
      String jsonData = json.encode(customerData);

      
      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertCustomer'), // Replace with your actual API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      
      if (response.statusCode == 200) {
        
        print('Customer added successfully');
        
      } else {
        
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      
      print('Error: $error');
    }
  }

  void getCustomer() async {
    try {
      
      final response = await http.get(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getcustomers'), 
        headers: {'Content-Type': 'application/json'},
      );

      
      if (response.statusCode == 200) {
        
        List<dynamic> customerData = json.decode(response.body);

        // Assuming the response is a list of customers
        List<Customer> customers =
            customerData.map((data) => Customer.fromJson(data)).toList();

        // Update the customerlist
        customerlist.assignAll(customers);

        for (int i = 0; i < customerlist.length; i++) {
          print(customerlist[i].customerName + ' ' + customerlist[i].contactInfo);
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
