import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

// Define the Customer class
class Customer {
  String customerName;
  String contactInfo;

  Customer({required this.customerName, required this.contactInfo});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerName: json['name'] ?? '',
      contactInfo: json['contactinfo'] ?? '',
    );
  }
}

// Controller to handle state and logic
class CustomerController extends GetxController {
  final box = GetStorage();
  RxList<Customer> customers = <Customer>[].obs;

  @override
  void onInit() {
    // Read data from storage when controller initializes
    if (box.hasData('customers')) {
      final storedCustomers = box.read<List>('customers')!;
      customers = storedCustomers.map((data) => Customer.fromJson(data)).toList().obs;
    }
    super.onInit();
  }

  void addCustomer(String name, String contactInfo) {
    customers.add(Customer(customerName: name, contactInfo: contactInfo));
    // Write data to storage whenever customers list is updated
    box.write('customers', customers.map((customer) => customer.toString()).toList());
  }
}

// Stateless widget to display the UI
class CustomerWidget extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Storage Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Add a new customer
              controller.addCustomer('John Doe', '1234567890');
            },
            child: Text('Add Customer'),
          ),
          Obx(() {
            // Display list of customers and their attributes
            return Expanded(
              child: ListView.builder(
                itemCount: controller.customers.length,
                itemBuilder: (context, index) {
                  Customer customer = controller.customers[index];
                  return ListTile(
                    title: Text('Name: ${customer.customerName}'),
                    subtitle: Text('Contact Info: ${customer.contactInfo}'),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: CustomerWidget(),
  ));
}