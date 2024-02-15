import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Controller/billing_controller.dart';
import 'billing_field.dart';

class BillingForm extends StatefulWidget {
  final ValueChanged<List<String?>> onDataListChanged;

  BillingForm({required this.onDataListChanged});

  @override
  State<BillingForm> createState() => _BillingFormState();
}

class _BillingFormState extends State<BillingForm> {
  List<String?> dataList = List.filled(4, null);
  BillingController billingcontroller = Get.put(BillingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              BillingField(
                icon: Icons.abc,
                hintText: "Enter Something",
                dropdownItems: billingcontroller.companyList,
                onDataChanged: (data) {
                  setState(() {
                    dataList[0] = data;
                    widget.onDataListChanged(dataList);
                  });
                },
              ),
              BillingField(
                icon: Icons.category,
                hintText: "Enter The Sub Category",
                dropdownItems: billingcontroller.categoryList,
                onDataChanged: (data) {
                  setState(() {
                    dataList[1] = data;
                    widget.onDataListChanged(dataList);
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              BillingField(
                icon: Icons.shopping_bag,
                hintText: "Enter The Product",
                dropdownItems: billingcontroller.productList,
                onDataChanged: (data) {
                  setState(() {
                    dataList[2] = data;
                    widget.onDataListChanged(dataList);
                  });
                },
              ),
              BillingField(
                icon: Icons.currency_rupee_sharp,
                hintText: "Enter The Price",
                dropdownItems: billingcontroller.productList,
                onDataChanged: (data) {
                  setState(() {
                    dataList[3] = data;
                    widget.onDataListChanged(dataList);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
