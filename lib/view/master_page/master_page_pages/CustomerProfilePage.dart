import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Controller/customer_profile_controller.dart';

class CustomerProfilePage extends StatelessWidget {
  CustomerProfilePageController customerProfilePage =
      Get.put(CustomerProfilePageController());
  final String customerName;
  final String contactInfo;

  CustomerProfilePage(
      {Key? key, required this.customerName, required this.contactInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Customer Name: $customerName"),
            Text("Contact Info: $contactInfo"),
            TextButton(
              onPressed: () {
                customerProfilePage.MoveCustomer(contactInfo);
              },
              child: Text("Move to Supplier"),
            ),
          ],
        ),
      ),
    );
  }
}
