import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/elevated_button.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/billing_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/Billing_field.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/billing_form.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/invoice.dart';
import 'package:lottie/lottie.dart';

class InventoryPage extends StatefulWidget {
   int shopId;
   int custId;

  InventoryPage({required this.shopId,required this.custId});
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  InventoryData singleData = InventoryData();
  BillingController billingController = Get.put(BillingController());
  TranscationController transcationcontroller =
      Get.find<TranscationController>();
  List<InventoryData> dataList = [];

  void handleDataListChange(List<dynamic> newDataList) {
    setState(() {
      singleData.abc = newDataList[0];
      singleData.category = newDataList[1];
      singleData.product = newDataList[2];
      singleData.quantity = int.tryParse(newDataList[3] ?? " ");
      singleData.total_price = double.tryParse(newDataList[4] ?? " ");
    });
  }

  void addItemToList() {
    if (singleData.abc != null &&
        singleData.category != null &&
        singleData.product != null &&
        billingController.quan.text.isNotEmpty) {
      int? quant = int.tryParse(billingController.quan.text);

      if (quant != null) {
        InventoryData newItem = InventoryData(
          abc: singleData.abc,
          category: singleData.category,
          product: singleData.product,
          quantity: quant,
          total_price: singleData.total_price,
        );

        singleData.abc = null;
        singleData.category = null;
        singleData.product = null;
        singleData.quantity = null;
        singleData.total_price = null;

        dataList.add(newItem);

        setState(() {});
      } else {
        print("Invalid quant format. Please enter a valid number.");
      }
    } else {
      print("Please fill all fields before adding to the list.");
    }
  }

  void deleteItemAtIndex(int index) {
    setState(() {
      dataList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Bill"),
        backgroundColor: AppColors.greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            BillingForm(onDataListChanged: handleDataListChange),
            SizedBox(height: 20),
            Text(
              (singleData.abc == null)
                  ? "Added Items will be Displayed here"
                  : " ${singleData.abc}, ${singleData.category}, ${singleData.product}, ${singleData.quantity}",
              style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: addItemToList,
              buttonText: "Add Item to List",
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 240,
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Center(child: Text("Item ${index + 1}")),
                            subtitle: Container(
                              width: 200,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Company: ${dataList[index].abc}"),
                                          Text(
                                              "Category: ${dataList[index].category}"),
                                          Text(
                                              "Product: ${dataList[index].product}"),
                                          Text(
                                              "Quantity: ${dataList[index].quantity}"),
                                          Text(
                                              "Price: ${dataList[index].total_price}"),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteItemAtIndex(index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: AppColors.redColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Invoice(dataList: dataList);
                  },
                );
              },
              child: Text("Preview"),
            ),
            TextButton(
              onPressed: () async {
                

                

                await billingController.postInventoryData(
                    widget.shopId,widget.custId, dataList,"1");
              },
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}
