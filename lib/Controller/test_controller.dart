// import 'package:get/get.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// class TestController extends GetxController {
//   void printURL() async {
//     final Uri url =
//         Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/$mobileno/AUTOGEN2');

//     final response = await http.get(url);
//     print(response);
//   }
// }

class TestController extends GetxController {
  void fetchDataAndPrint() async {
    try {
      final response = await http.get(Uri.parse(
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getcustomers'));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        for (var user in dataList) {
          print('User ID: ${user['customerid']}');
          print('Username: ${user['name']}');
          print('Email: ${user['contactinfo']}');
          print('---');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  
}
