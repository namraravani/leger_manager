import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/supplier_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/contact_view.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/Customer_add.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Bill_Module/ViewBills.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Supplier_Module/add_supplier.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/test_contact_view.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SupplierPage extends StatefulWidget {
  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  SupplierController suppliercontroller = Get.put(SupplierController());

  TranscationController transactioncontroller =
      Get.put(TranscationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
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
                buildSupplierListView(),
              ],
            ),
            onRefresh: () async {
              await suppliercontroller.getSuppliers(
                  await suppliercontroller.getShopId("9427662325"));
              await suppliercontroller.loadLastTransactionDataForCustomers(
                  suppliercontroller.supplierlist);
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Get.to(SupplierAddPage());
              },
              child: Icon(Icons.person_add_alt_1),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupplierListView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Obx(
          () {
            if (suppliercontroller.supplierlist.isEmpty) {
              return Center(child: buildEmptyListAnimation());
            } else {
              return ListView.builder(
                itemCount: suppliercontroller.supplierlist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          int shop_id = await transactioncontroller
                              .getShopId("9427662325");
                          int cust_id = await transactioncontroller
                              .getCustomerID(suppliercontroller
                                  .supplierlist[index].contactInfo);
                          transactioncontroller.getAlltranscation(
                              shop_id, cust_id);
                          Get.to(TransactionPage(
                            customerName: suppliercontroller
                                .supplierlist[index].customerName,
                            contactinfo: suppliercontroller
                                .supplierlist[index].contactInfo,
                          ));
                        },
                        leading: InitialsAvatar(
                            name: suppliercontroller
                                .supplierlist[index].customerName),
                        title: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(suppliercontroller
                                  .supplierlist[index].customerName),
                              Spacer(),
                              if (suppliercontroller.totalSumList.isNotEmpty &&
                                  index <
                                      suppliercontroller.totalSumList.length)
                                Text(
                                  "${suppliercontroller.totalSumList[index] < 0 ? suppliercontroller.totalSumList[index].abs() : suppliercontroller.totalSumList[index]}",
                                  style: TextStyle(
                                    color:
                                        suppliercontroller.totalSumList[index] <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                  ),
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
                              if (suppliercontroller
                                      .lastTransactionList.isNotEmpty &&
                                  index <
                                      suppliercontroller
                                          .lastTransactionList.length)
                                Text(
                                  suppliercontroller
                                      .lastTransactionList[index].data,
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              SizedBox(width: 5),
                              if (suppliercontroller
                                      .lastTransactionList.isNotEmpty &&
                                  index <
                                      suppliercontroller
                                          .lastTransactionList.length)
                                Text(
                                    "Payment added on ${suppliercontroller.formatDateTime(suppliercontroller.lastTransactionList[index].transcationTime)}"),
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
              'assets/animations/supplier_page.json',
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
