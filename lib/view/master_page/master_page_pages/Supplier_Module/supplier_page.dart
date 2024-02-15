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

class SupplierPage extends StatelessWidget {
  SupplierController suppliercontroller = Get.put(SupplierController());
  TranscationController transactioncontroller =
      Get.put(TranscationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildSupplierListView(),
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
        () => ListView.builder(
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
                    transactioncontroller.getAlltranscation(shop_id, cust_id);
                    Get.to(TransactionPage(
                      customerName:
                          suppliercontroller.supplierlist[index].customerName,
                      contactinfo:
                          suppliercontroller.supplierlist[index].contactInfo,
                    ));
                  },
                  leading: InitialsAvatar(
                      name:
                          suppliercontroller.supplierlist[index].customerName),
                  title:
                      Text(suppliercontroller.supplierlist[index].customerName),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 17,
                      ),
                      Text(
                        "52",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Payment added on 04Feb,2024"),
                    ],
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
        ),
      ),
    );
  }
}
