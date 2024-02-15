import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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
      singleData.price = newDataList[3];
    });

    if (singleData.abc != null) {
      // Send data to BillingController
      billingController.getCategory(singleData.abc!);
    }
  }

  void addItemToList() {
    // Check if all values are non-null before adding to the list
    if (singleData.abc != null &&
        singleData.category != null &&
        singleData.product != null &&
        singleData.price != null) {
      // Create a new InventoryData object and add it to the list
      InventoryData newItem = InventoryData(
        abc: singleData.abc,
        category: singleData.category,
        product: singleData.product,
        price: singleData.price,
      );

      // Clear the previous values
      singleData.abc = null;
      singleData.category = null;
      singleData.product = null;
      singleData.price = null;

      // Add the new item to the list
      dataList.add(newItem);

      // Update the UI
      setState(() {});
    } else {
      // Show an error message or handle the case where some values are null
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
          Container(
            height: 100,
            child: Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Item ${index + 1}"),
                    subtitle: Container(
                      width: 200,
                      child: Row(
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
          BillingForm(onDataListChanged: handleDataListChange),
          SizedBox(height: 20),
          Text(
              "Data from BillingForm: ${singleData.abc}, ${singleData.category}, ${singleData.product}, ${singleData.price}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: addItemToList,
            child: Text("Add Item to List"),
          ),
        ],
      ),
    );
  }
}
