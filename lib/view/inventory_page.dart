import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Controller/test_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class InventoryPage extends StatelessWidget {
  // final TestController loginController = Get.put(TestController());
  InventoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Item In Inventory to Avoid Hasslefree process of bill making",
                  style: TextStyle(fontSize: 20),
                ),
                Lottie.asset(
                  'assets/animations/inventory_page_animation.json',
                  height: 250,
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://jxwd92bcj0.execute-api.ap-south-1.amazonaws.com/test/customers');

                // Your JSON data
                Map<String, String> jsonData = {
                  
                  "Item": "asfjs",
                };

                final response = await http.post(
                  url,
                  body: jsonEncode(jsonData), // Encode your JSON data
                );

                if (response.statusCode == 200) {
                  // Request successful, handle response
                  String jsonsDataString = response.body.toString();
                  print(jsonsDataString);
                  print(response);
                } else {
                  // Request failed
                  print('Request failed with status: ${response.statusCode}');
                }
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
