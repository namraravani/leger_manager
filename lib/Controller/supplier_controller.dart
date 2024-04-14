import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:leger_manager/Classes/customer.dart';

class SupplierController extends GetxController {
  RxList<Customer> supplierlist = <Customer>[].obs;
  TextEditingController supplier_name = TextEditingController();
  TextEditingController supplier_contact_info = TextEditingController();
  var isConnected = false.obs;

  @override
  void onInit() async {
    updateConnectionStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi);
    });

    if (isConnected == true) {
      getSuppliers(await getShopId("9427662325"));
    } else {
      print("hello from supplier");
    }

    super.onInit();
  }

  void updateConnectionStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

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

  Future<void> postSupplier(int shopId) async {
    try {
      if (supplier_name.text.isEmpty || supplier_contact_info.text.isEmpty) {
        return;
      }

      Map<String, dynamic> customerData = {
        'name': supplier_name.text,
        'contactinfo': supplier_contact_info.text,
        'type': 0
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertCustomer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        getSuppliers(shopId);
        print('Supplier added successfully');
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> postSupplierfromContact(
      int shopId, String name, String Phonenumber) async {
    try {
      if (name.isEmpty || Phonenumber.isEmpty) {
        return;
      }

      Map<String, dynamic> customerData = {
        'name': name,
        'contactinfo': Phonenumber,
        'type': 0
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertCustomer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        getSuppliers(shopId);
        print('Supplier added successfully');
      } else {
        print('Error adding Supplier: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getSuppliers(int shopId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getsuppliersbyshopid'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'shopid': shopId}),
      );

      if (response.statusCode == 200) {
        List<dynamic> customerData = json.decode(response.body);

        List<Customer> customers =
            customerData.map((data) => Customer.fromJson(data)).toList();

        supplierlist.assignAll(customers);
        update();

        for (int i = 0; i < supplierlist.length; i++) {
          print(
              supplierlist[i].customerName + ' ' + supplierlist[i].contactInfo);
        }
      } else {
        print('Error fetching customers: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions
      print('Error: $error');
    }
  }
}
