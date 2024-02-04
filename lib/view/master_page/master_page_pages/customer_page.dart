import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/GetInitials.dart';
import 'package:leger_manager/Components/RandomColor.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/Controller/test_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_add.dart';
import 'package:leger_manager/view/master_page/master_page_pages/transaction_page.dart';
import 'package:leger_manager/view/test_contact_view.dart';
import 'package:lottie/lottie.dart';

class CustomerPage extends StatelessWidget {
  final TestController testController = Get.put(TestController());
  final CustomerController customercontroller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // buildEmptyListAnimation()
          buildCustomerListView(),
          Positioned(
            bottom: 16.0,
            right: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () async {
                    Get.to(CustomerListPage());
                  },
                  child: Icon(Icons.person_add_alt_1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomerListView() {
    return Obx(
      () => ListView.builder(
        itemCount: customercontroller.customerlist.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Get.to(TransactionPage(
                    customerName:
                        customercontroller.customerlist[index].customerName,
                    contactinfo:
                        customercontroller.customerlist[index].contactInfo,
                  ));
                },
                leading: InitialsAvatar(
                    name: customercontroller.customerlist[index].customerName),
                title:
                    Text(customercontroller.customerlist[index].customerName),
                subtitle:
                    Text(customercontroller.customerlist[index].contactInfo),
              ),
              Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Colors.grey,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildEmptyListAnimation() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Start Your Journey with Ledger Manager"),
            Lottie.asset(
              'assets/animations/start_page_animation.json',
              height: 250,
              reverse: true,
              repeat: true,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
