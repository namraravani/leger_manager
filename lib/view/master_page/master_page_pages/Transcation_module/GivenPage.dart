import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/general_txtfld.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/inventory_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';

class GivenPage extends StatelessWidget {
  TranscationController transcationcontroller =
      Get.find<TranscationController>();

  CustomerController customercontroller = Get.find<CustomerController>();
  final String customerName;
  final String customerInfo;

  GivenPage({
    Key? key,
    required this.customerName,
    required this.customerInfo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InitialsAvatar(name: customerName ?? ''),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  customerName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Text(
                  "View Profile",
                  style: TextStyle(fontSize: 14, color: Colors.indigoAccent),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.currency_rupee_sharp,
                color: AppColors.redColor,
              ),
              Container(
                width: 100,
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(fontSize: 25, color: AppColors.redColor),
                      keyboardType: TextInputType.number,
                      controller: transcationcontroller.data,
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 300,
            child: TextField(
              style: TextStyle(fontSize: 25, color: AppColors.redColor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Note Optional",
                  labelText: "Enter Note",
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.redColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.redColor),
                  )),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.redColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: AppColors.redColor,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.redColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      Get.to(InventoryPage(
                        shopId:
                            await transcationcontroller.getShopId("9427662325"),
                        custId: await transcationcontroller
                            .getCustomerID(customerInfo),
                      ));
                    },
                    icon: Icon(
                      Icons.receipt_long,
                      color: AppColors.redColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: AppColors.redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.redColor),
              ),
            ),
            onPressed: () async {
              if (transcationcontroller.data.text.isNotEmpty) {
                num amt;

                try {
                  String textValue = transcationcontroller.data.text;

                  if (textValue.isNotEmpty) {
                    amt = num.parse(textValue);

                    print("Numeric value: $amt");
                  } else {
                    print("Input is empty");
                    return;
                  }
                } catch (e) {
                  print(
                      "Invalid input: ${transcationcontroller.data.text} is not a valid number");
                  return;
                }

                Get.off(TransactionPage(
                  customerName: customerName,
                  contactinfo: customerInfo,
                ));

                transcationcontroller.data.clear();
                customercontroller.getCustomer();

                String mobileNumber = transcationcontroller.mobileNumber.value;

                int shop_id =
                    await transcationcontroller.getShopId("9427662325");
                int cust_id =
                    await transcationcontroller.getCustomerID(customerInfo);

                transcationcontroller.postTranscation(
                  shop_id.toString(),
                  cust_id.toString(),
                  amt,
                  '1',
                );
              }
            },
            child: Text("Add"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
