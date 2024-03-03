import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leger_manager/Controller/billing_controller.dart';
import 'billing_field.dart';

class BillingForm extends StatefulWidget {
  final ValueChanged<List<dynamic>> onDataListChanged;

  BillingForm({required this.onDataListChanged});

  @override
  State<BillingForm> createState() => _BillingFormState();
}

class _BillingFormState extends State<BillingForm> {
  List<dynamic> dataList = List.filled(5, null);
  BillingController billingcontroller = Get.put(BillingController());
  double productPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Obx(
                () => BillingField(
                  icon: Icons.factory_sharp,
                  hintText: "Enter Company Name",
                  dropdownItems: billingcontroller.companyList.value,
                  onDataChanged: (data) {
                    setState(() {
                      dataList[0] = data;
                      widget.onDataListChanged(dataList.cast<String?>());
                    });
                  },
                ),
              ),
              Obx(
                () => BillingField(
                  icon: Icons.category,
                  hintText: "Enter The Sub Category",
                  dropdownItems: billingcontroller.productList.value,
                  onDataChanged: (data) {
                    setState(() {
                      dataList[1] = data;
                      widget.onDataListChanged(dataList.cast<String?>());
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Obx(
                () => BillingField(
                  icon: Icons.shopping_bag,
                  hintText: "Enter The Product",
                  dropdownItems: billingcontroller.productList.value,
                  onDataChanged: (data) {
                    setState(() {
                      dataList[2] = data;
                      widget.onDataListChanged(dataList.cast<String?>());

                      int index = billingcontroller.productList.indexOf(data);
                      if (index != -1 &&
                          index < billingcontroller.productpriceList.length) {
                        String productPriceString =
                            billingcontroller.productpriceList[index];
                        print(
                            "Hello Namra I am Here I am Product Price : ${productPriceString}");
                        productPrice =
                            double.tryParse(productPriceString) ?? 0.0;

                        print(
                            "Hello Namra I am Here I am Product Price : ${productPrice}");
                        // Now you can use the productPrice as needed
                      }
                    });
                  },
                ),
              ),
              Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    Expanded(
                      child: TextField(
                        onChanged: (data) {
                          setState(() {
                            dataList[3] = data;
                            widget.onDataListChanged(dataList.cast<String?>());
                            int quantity = int.tryParse(data) ?? 0;
                            String finProductPriceAsString =
                                (productPrice * quantity).toString();
                            print("${finProductPriceAsString}");
                            dataList[4] = finProductPriceAsString;
                            widget.onDataListChanged(dataList.cast<String?>());
                          });
                        },
                        controller: billingcontroller.quan,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Quantity"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
