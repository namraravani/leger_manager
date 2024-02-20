import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
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
  InventoryData singleData = InventoryData();
  BillingController billingController = Get.put(BillingController());
  List<InventoryData> dataList = [];

  void handleDataListChange(List<String?> newDataList) {
    setState(() {
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

  void deleteItemAtIndex(int index) {
    setState(() {
      dataList.removeAt(index);
    });
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
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 300,
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
                                        Text("Company: ${dataList[index].abc}"),
                                        Text(
                                            "Category: ${dataList[index].category}"),
                                        Text(
                                            "Product: ${dataList[index].product}"),
                                        Text("Price: ${dataList[index].price}"),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                  return Container(
                    height: 2000,
                    child: Center(
                      child: Container(
                        height: 400,
                        width: 300,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(
                              "Namra",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Invoice",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Generated by Ledger Manager",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Date : " +
                                  DateFormat('d/M/yyyy').format(DateTime.now()),
                              style: TextStyle(fontSize: 15),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Item",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Company",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Category",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Product",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Quantity",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Price",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Divider(),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 220,
                              child: ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${index + 1}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${dataList[index].abc}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${dataList[index].category}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${dataList[index].product}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "1",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${dataList[index].price}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total"),
                                Text("293"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text("Preview"),
          ),
        ],
      ),
    );
  }
}
