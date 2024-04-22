import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/common_input_formatters.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';

class ReceviedPage extends StatefulWidget {
  final String customerName;
  final String customerInfo;

  ReceviedPage({
    Key? key,
    required this.customerName,
    required this.customerInfo,
  }) : super(key: key);

  @override
  _ReceviedPageState createState() => _ReceviedPageState();
}

class _ReceviedPageState extends State<ReceviedPage> {
  TranscationController transcationcontroller =
      Get.find<TranscationController>();
  CustomerController customercontroller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InitialsAvatar(name: widget.customerName ?? ''),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.customerName,
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
                color: AppColors.greenColor,
              ),
              Container(
                width: 100,
                child: TextField(
                  style: TextStyle(fontSize: 25, color: AppColors.greenColor),
                  keyboardType: TextInputType.number,
                  inputFormatters: getCommonInputFormatters(),
                  controller: transcationcontroller.data,
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ],
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
                    color: AppColors.greenColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: AppColors.greenColor,
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
                    color: AppColors.greenColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_box_outlined,
                    size: 40,
                    color: AppColors.greenColor,
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
              onPrimary: AppColors.greenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.greenColor),
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

                // transcationcontroller.transcationlist.add(Transcation(
                //   data: transcationcontroller.data.text,
                //   variable: 0,
                // ));

                Get.off(TransactionPage(
                  customerName: widget.customerName,
                  contactinfo: widget.customerInfo,
                ));

                transcationcontroller.data.clear();
                customercontroller.getCustomer();

                String mobileNumber = transcationcontroller.mobileNumber.value;

                int shop_id =
                    await transcationcontroller.getShopId("9427662325");
                int cust_id = await transcationcontroller
                    .getCustomerID(widget.customerInfo);

                transcationcontroller.postTranscation(
                  shop_id.toString(),
                  cust_id.toString(),
                  amt,
                  '0',
                );

                customercontroller.getCustomer();

                // setState(() {});
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
