import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
          Column(
            children: [
              Obx(
                () => BillingField(
                  icon: Icons.abc,
                  hintText: "Enter Something",
                  dropdownItems: billingcontroller.companyList.value,
                  onDataChanged: (data) {
                    setState(() {
                      dataList[0] = data;
                      widget.onDataListChanged(dataList);
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
                      widget.onDataListChanged(dataList);
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
                      widget.onDataListChanged(dataList);
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
                    Icon(Icons.currency_rupee_sharp),
                    Expanded(
                      child: TextField(
                        controller: billingcontroller.amt,
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Enter Amount"),
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
