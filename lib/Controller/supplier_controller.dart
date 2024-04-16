import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Classes/customer.dart';

class SupplierController extends GetxController {
  RxList<Customer> supplierlist = <Customer>[].obs;
  TextEditingController supplier_name = TextEditingController();
  TextEditingController supplier_contact_info = TextEditingController();
  RxList<Transcation> lastTransactionList = <Transcation>[].obs;
  RxList<double> totalSumList = <double>[].obs;
  List<double> alltemporarysums = [];
  bool isCustomerListLoaded = false;
  var isConnected = false.obs;

  @override
  void onInit() async {
    // updateConnectionStatus();
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   isConnected.value = (result == ConnectivityResult.mobile ||
    //       result == ConnectivityResult.wifi);
    // });

    // if (isConnected == true) {
    getSuppliers(await getShopId("9427662325"));
    // } else {
    //   print("hello from supplier");
    // }

    // super.onInit();
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

        loadLastTransactionDataForCustomers(supplierlist);
      } else {
        print('Error fetching customers: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions
      print('Error: $error');
    }
  }

  Future<Transcation> getlasttranscation(int shopid, int customer_id) async {
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

        return transcationList.last;
      } else {
        print(
            "Failed to get transactions. Status Code: ${response.statusCode}");
        throw Exception(
            "Failed to get transactions. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Error: $error");
      // Handle other exceptions here
    }
  }

  Future<double> calculatesum(int shopid, int customer_id) async {
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

        List<double> summedDataValues = transcationList.map((transaction) {
          double amount = double.parse(transaction.data);
          return transaction.variable == '1' ? -amount : amount;
        }).toList();

        double totalSum =
            summedDataValues.fold(0, (previous, current) => previous + current);

        return Future.value(totalSum);
      } else {
        print(
            "Failed to get transactions. Status Code: ${response.statusCode}");
        throw Exception(
            "Failed to get transactions. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }

  Future<void> loadLastTransactionDataForCustomers(
      List<Customer> customers) async {
    try {
      totalSumList.clear();
      lastTransactionList.clear();
      totalSumList.clear();
      List<Transcation> allLastTransactions = [];
      List<double> alltemporarysums = [];

      for (Customer customer in customers) {
        try {
          int customerID = await getCustomerID(customer.contactInfo);
          int shopID = await getShopId("9427662325");

          Transcation lastTransaction =
              await getlasttranscation(shopID, customerID);

          double totalSum = await calculatesum(shopID, customerID);
          allLastTransactions.add(lastTransaction);
          alltemporarysums.add(totalSum);
        } catch (error) {
          print("Hello There is an Error");
        }
      }

      lastTransactionList.addAll(allLastTransactions);
      totalSumList.addAll(alltemporarysums);
    } catch (error) {
      print('Error loading last transaction data: $error');
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

  String formatDateTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('ddMMM,y');
    return formatter.format(dateTime);
  }

  String? validateCustomerName(String value) {
  if (value.isEmpty) {
    return 'Please enter your name';
  }
  // Additional validation rules can be added here
  return null; // Return null if the input is valid
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter your phone number';
  }
  // Validate phone number format using a regular expression
  // For example, checking if it's a valid 10-digit number
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Please enter a valid 10-digit phone number';
  }
  return null; // Return null if the input is valid
}
}
