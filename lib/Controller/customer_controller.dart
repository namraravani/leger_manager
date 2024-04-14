import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Controller/network_controller.dart';
import 'package:path_provider/path_provider.dart';

class CustomerController extends GetxController {
  RxList<Customer> customerlist = <Customer>[].obs;
  RxList<Customer> customerlist1 = <Customer>[].obs;
  TextEditingController customername = TextEditingController();
  TextEditingController customerinfo = TextEditingController();
  RxList<Transcation> lastTransactionList = <Transcation>[].obs;
  RxList<double> totalSumList = <double>[].obs;
  List<double> alltemporarysums = [];
  bool isCustomerListLoaded = false;
  RxList<Customer> storedcustomerlist = <Customer>[].obs;
  int count = 0;

  final box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    // final NetworkController networkController = Get.find<NetworkController>();

    // print(networkController.isConnected.value);

    getCustomer();

    

    // Access isConnected value
    // bool isConnected = networkController.isConnected.value;

    // // Use the value to perform actions based on internet connectivity status
  }

  void updateData() {
    loadLastTransactionDataForCustomers(customerlist);
  }

  Future<void> postCustomer() async {
    try {
      if (customername.text.isEmpty || customerinfo.text.isEmpty) {
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
        Customer cust = Customer(
          customerName: customername.text,
          contactInfo: customerinfo.text,
        );
        writeToLocalStorage(cust);
        await getCustomer();
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<List<Customer>> readFromLocalStorage() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/customers.json');

    if (!await file.exists()) {
      return []; // Return an empty list if the file doesn't exist.
    }

    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);
    final List<Customer> customers = jsonData
        .map((dynamic item) => Customer.fromJson(item as Map<String, dynamic>))
        .toList();

    print(customers);

    return customers;
  }

  void postCustomerFromContact(String name, String Phonenumber) async {
    try {
      if (name.isEmpty || Phonenumber.isEmpty) {
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
        getCustomer();
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

        loadLastTransactionDataForCustomers(customerlist);
      } else {
        print('Error fetching customers: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> writeToLocalStorage(Customer customer) async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/customers.json');

    List<Customer> customers = [];

    // Check if the file exists to either read its contents or initialize an empty list
    if (await file.exists()) {
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      customers = jsonData.map((item) => Customer.fromJson(item)).toList();
    }

    // Append the new customer to the list
    customers.add(customer);

    // Convert the list of Customer objects to a list of maps
    final List<Map<String, dynamic>> customerData =
        customers.map((c) => c.toJson()).toList();

    // Write the updated list back to the file
    await file.writeAsString(json.encode(customerData));
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
