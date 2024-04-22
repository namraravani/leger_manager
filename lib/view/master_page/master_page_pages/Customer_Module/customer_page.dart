import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';

import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/Controller/test_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/Customer_add.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Bill_Module/ViewBills.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/test_contact_view.dart';
import 'package:lottie/lottie.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TranscationController transactioncontroller =
      Get.put(TranscationController());

  final CustomerController customercontroller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await customercontroller.getCustomer();
              await customercontroller.loadLastTransactionDataForCustomers(
                  customercontroller.customerlist);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ViewBill());
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.secondaryColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "View Bills",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.secondaryColor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                buildCustomerListView(),
              ],
            ),
          ),
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Obx(
          () {
            if (customercontroller.customerlist.isEmpty) {
              return Center(child: buildEmptyListAnimation());
            } else {
              return ListView.builder(
                itemCount: customercontroller.customerlist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          int shop_id = await transactioncontroller
                              .getShopId("9427662325");
                          int cust_id = await transactioncontroller
                              .getCustomerID(customercontroller
                                  .customerlist[index].contactInfo);
                          print(shop_id);
                          transactioncontroller.getAlltranscation(
                              shop_id, cust_id);
                          Get.to(TransactionPage(
                            customerName: customercontroller
                                .customerlist[index].customerName,
                            contactinfo: customercontroller
                                .customerlist[index].contactInfo,
                          ));
                        },
                        leading: InitialsAvatar(
                            name: customercontroller
                                .customerlist[index].customerName),
                        title: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(customercontroller
                                  .customerlist[index].customerName),
                              Spacer(),
                              if (customercontroller.totalSumList.isNotEmpty &&
                                  index <
                                      customercontroller.totalSumList.length)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 15,
                                      color: customercontroller
                                                  .totalSumList[index] <
                                              0
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    Text(
                                      "${customercontroller.totalSumList[index] < 0 ? customercontroller.totalSumList[index].abs() : customercontroller.totalSumList[index]}",
                                      style: TextStyle(
                                        color: customercontroller
                                                    .totalSumList[index] <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        subtitle: Obx(
                          () => Row(
                            children: [
                              Icon(
                                Icons.currency_rupee_sharp,
                                size: 17,
                              ),
                              if (customercontroller
                                      .lastTransactionList.isNotEmpty &&
                                  index <
                                      customercontroller
                                          .lastTransactionList.length)
                                Text(
                                  customercontroller
                                      .lastTransactionList[index].data,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              SizedBox(width: 5),
                              if (customercontroller
                                      .lastTransactionList.isNotEmpty &&
                                  index <
                                      customercontroller
                                          .lastTransactionList.length)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Payment added on ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        "${customercontroller.formatDateTime(customercontroller.lastTransactionList[index].transcationTime)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                      Spacer(),
                                      customercontroller.totalSumList[index] < 0
                                          ? Text(
                                              "DUE",
                                              style: TextStyle(
                                                  color: AppColors.redColor,
                                                  fontSize: 9),
                                            )
                                          : Text(
                                              "ADVANCE",
                                              style: TextStyle(
                                                  color: AppColors.greenColor,
                                                  fontSize: 9),
                                            )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
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
              );
            }
          },
        ),
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
