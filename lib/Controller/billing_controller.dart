import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';

class BillingController extends GetxController {
  RxList<String> companyList = <String>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxList<String> productList = <String>[].obs;
  RxList<String> productpriceList = <String>[].obs;
  List<int> priceindexList = [];
  RxInt selectedProductIndex = RxInt(-1);
  TextEditingController quan = TextEditingController();
  int? amount;
  int? parsedPrice;

  @override
  void onInit() {
    getCompany();
    getProduct("Wafers");
    super.onInit();
  }

  void updateSelectedProductIndex(int index) {
    selectedProductIndex.value = index;

    // Fetch the price from the product price list
    if (index >= 0 && index < productpriceList.length) {
      // Use int.tryParse to handle cases where the string is not a valid integer
      parsedPrice = int.tryParse(productpriceList[index]) ?? 0;
    } else {
      parsedPrice = 0;
    }
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

  Future<void> updateCompanyList() async {
    try {
      // Make an API call to get the updated company list
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
          List<String> updatedCompanyList =
              List<String>.from(jsonResponse.map((item) => item['company']));

          // Clear the existing companyList and add the updated companies
          companyList.clear();
          companyList.addAll(updatedCompanyList);

          // Update the UI
          update();

          // Print the updated company list
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
        List<Map<String, dynamic>> jsonResponse =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        if (jsonResponse.isNotEmpty && jsonResponse[3].containsKey('product')) {
          // Extract product names and prices into separate lists
          List<String> productNames =
              jsonResponse.map((item) => item['product'] as String).toList();

          List<String> productPrices =
              jsonResponse.map((item) => item['price'] as String).toList();

          // Clear the existing lists and add the new data
          productList.clear();
          productList.addAll(productNames);
          productpriceList.clear();
          productpriceList.addAll(productPrices);

          // Update the UI
          update();

          // Print the entire response for debugging
          print('API Response: $jsonResponse');

          // Print the product lists
          productList.forEach((productName) {
            print('Product Name: $productName');
          });

          productpriceList.forEach((productPrice) {
            print('Product Price: $productPrice');
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

  double calculateTotalPrice(List<InventoryData> datalist) {
    double total = 0.0;
    for (InventoryData data in datalist) {
      total += data.total_price ?? 0.0;
    }

    return total;
  }

  // int calculatePrice(int index, InventoryData data) {
  //   try {
  //     // Check if index is within bounds
  //     if (index >= 0 && index < productpriceList.length) {
  //       // Fetch the price at the specified index and convert it to an integer
  //       int productPrice = int.tryParse(productpriceList[index]) ?? 0;

  //       // Multiply the product price by the quantity (data.price)
  //       int calculatedPrice = productPrice * (data.price ?? 0);

  //       // Print the calculated price for debugging
  //       print('Calculated Price: $calculatedPrice');

  //       return calculatedPrice;
  //     } else {
  //       print('Error: Index out of bounds');
  //     }
  //   } catch (error) {
  //     print('Error calculating price: $error');
  //   }

  //   // Return 0 in case of errors or invalid index
  //   return 0;
  // }

  Future<void> postInventoryData(int shopId, int customerId,
      List<InventoryData> inventoryList, String type) async {
    try {
      print(shopId);
      print(customerId);
      for (int i = 0; i < inventoryList.length; i++) {
        print(inventoryList[i].abc);
        print(inventoryList[i].category);
      }
      if (inventoryList.isEmpty) {
        return;
      }

      List<Map<String, dynamic>> itemsList = inventoryList
          .map((data) => {
                'company': data.abc,
                'category': data.category,
                'product': data.product,
                'quantity': data.quantity,
                'price': data.total_price,
              })
          .toList();

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/createtranscation'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "customerid": customerId,
          "amount": calculateTotalPrice(inventoryList),
          "type": "1",
          "shopid": shopId,
          'items': itemsList,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully posted the inventory data
        print('Inventory data posted successfully');
      } else {
        print('Error posting inventory data: ${response.statusCode}');
        // Print additional details if available
        if (response.body.isNotEmpty) {
          print('Error Details: ${response.body}');
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
