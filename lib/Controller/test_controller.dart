// import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

// class TestController extends GetxController {
//   void printURL() async {
//     final Uri url =
//         Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/$mobileno/AUTOGEN2');

//     final response = await http.get(url);
//     print(response);
//   }
// }

void fetchDataAndPrint() async {
                  try {
                    final response = await http.get(Uri.parse(
                        'https://0lpt7qsle9.execute-api.ap-south-1.amazonaws.com/items'));

                    if (response.statusCode == 200) {
                      
                      final List<dynamic> dataList = json.decode(response.body);

                      
                      dataList.sort((a, b) => a['id'].compareTo(b['id']));

                      
                      print(dataList);
                    } else {
                      print(
                          'Failed to load data. Status code: ${response.statusCode}');
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                }

                
