import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/elevated_button.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/billing_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/Billing_field.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/billing_form.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';
import 'package:lottie/lottie.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // Use a single instance of InventoryData
  InventoryData singleData = InventoryData();
  BillingController billingController = Get.put(BillingController());
  List<InventoryData> dataList = [];

  void handleDataListChange(List<String?> newDataList) {
    setState(() {
      // Update the singleData using the InventoryData class
      singleData.abc = newDataList[0];
      singleData.category = newDataList[1];
      singleData.product = newDataList[2];
      singleData.price = int.tryParse(newDataList[3] ?? " ");
    });

    if (singleData.abc != null) {
      
      billingController.getCategory(singleData.abc!);
    }
  }

  void addItemToList() {
    if (singleData.abc != null &&
        singleData.category != null &&
        singleData.product != null &&
        billingController.amt.text.isNotEmpty) {
      // Convert the String to int
      int? amount = int.tryParse(billingController.amt.text);

      if (amount != null) {
        // Create a new InventoryData object and add it to the list
        InventoryData newItem = InventoryData(
          abc: singleData.abc,
          category: singleData.category,
          product: singleData.product,
          price: amount,
        );

        // Clear the previous values
        singleData.abc = null;
        singleData.category = null;
        singleData.product = null;
        singleData.price = null;

        // Add the new item to the list
        dataList.add(newItem);

        setState(() {});
      } else {
        print("Invalid amount format. Please enter a valid number.");
      }
    } else {
      print("Please fill all fields before adding to the list.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parent Widget"),
      ),
      body: Column(
        children: [
          BillingForm(onDataListChanged: handleDataListChange),
          SizedBox(height: 20),
          Text(
            (singleData.abc == null)
                ? "Added Items will be Displayed here"
                : " ${singleData.abc}, ${singleData.category}, ${singleData.product}, ${singleData.price}",
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
                    height: 350,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: dataList.length * 200,
                              child: Column(
                                children: [
                                  Text(
                                    "List of Items",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: AppColors.secondaryColor),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text("Item ${index + 1}"),
                                          subtitle: Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "ABC: ${dataList[index].abc}"),
                                                Text(
                                                    "Category: ${dataList[index].category}"),
                                                Text(
                                                    "Product: ${dataList[index].product}"),
                                                Text(
                                                    "Price: ${dataList[index].price}"),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Item ${index + 1}"),
                            subtitle: Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ABC: ${dataList[index].abc}"),
                                  Text("Category: ${dataList[index].category}"),
                                  Text("Product: ${dataList[index].product}"),
                                  Text("Price: ${dataList[index].price}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
