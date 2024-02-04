import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/customer_page.dart';
import 'package:leger_manager/view/test_contact_view.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  CustomerController customercontroller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: customercontroller.customername,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: customercontroller.customerinfo,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // customercontroller.addCustomer();
                    customercontroller.postCustomer();
                    // Get.off(CustomerPage());
                  },
                  child: Text('Add Customer'),
                ),
                TextButton(
                  onPressed: () {
                    // customercontroller.addCustomer();
                    Get.off(ContactViewPage());
                    // Get.off(CustomerPage());
                  },
                  child: IconLogo(
                      icon: Icon(Icons.contact_phone),
                      name: Text("Add From Contacts")),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
