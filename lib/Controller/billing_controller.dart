import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BillingController extends GetxController {
  RxList<String> companyList = <String>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxList<String> productList = <String>[].obs;

  @override
  void onInit() {
    getCompany();
    getProduct("Wafers");
    super.onInit();
  }

  Future<void> getCompany() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchcompany',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response as a List
        List<dynamic> jsonResponse = json.decode(response.body);

        
        if (jsonResponse.isNotEmpty && jsonResponse[0].containsKey('company')) {
          
          String company = jsonResponse[0]['company'];

          companyList.add(company);

          update();

          
          companyList.forEach((company) {
            print(company);
          });
        } else {
          print('Error: Invalid JSON structure');
        }
      } else {
        print('Error fetching company: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getCategory(String company) async {
    print(company);
    try {
      final response = await http.post(
        Uri.parse(
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchcategory',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'company': company}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty &&
            jsonResponse[0].containsKey('subcategory')) {
          List<String> subcategories = List<String>.from(
              jsonResponse.map((item) => item['subcategory']));

          
          categoryList.clear();
          categoryList.addAll(subcategories);

          // Update the UI
          update();

          // Print the category list
          categoryList.forEach((subcategory) {
            print(subcategory);
          });
        } else {
          print('Error: Invalid JSON structure');
        }
      } else {
        print('Error fetching subcategories: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getProduct(String subcategory) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchproduct',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'subcategory': subcategory}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty && jsonResponse[3].containsKey('product')) {
          // Assuming the API response is a list of subcategories
          List<String> products =
              List<String>.from(jsonResponse.map((item) => item['product']));

          // Clear the existing categoryList and add the new subcategories
          productList.clear();
          productList.addAll(products);

          // Update the UI
          update();

          // Print the category list
          productList.forEach((product) {
            print(product);
          });
        } else {
          print('Error: Invalid JSON structure');
        }
      } else {
        print('Error fetching subcategories: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
