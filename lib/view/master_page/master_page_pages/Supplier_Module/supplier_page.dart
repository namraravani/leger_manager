import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/supplier_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/contact_view.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/Customer_add.dart';
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
            child: buildSupplierListView(),
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
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
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
                        int shop_id =
                            await transactioncontroller.getShopId("9427662325");
                        int cust_id = await transactioncontroller.getCustomerID(
                            suppliercontroller.supplierlist[index].contactInfo);
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
                                index < suppliercontroller.totalSumList.length)
                              Text(
                                "${suppliercontroller.totalSumList[index] < 0 ? suppliercontroller.totalSumList[index].abs() : suppliercontroller.totalSumList[index]}",
                                style: TextStyle(
                                  color:
                                      suppliercontroller.totalSumList[index] < 0
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
