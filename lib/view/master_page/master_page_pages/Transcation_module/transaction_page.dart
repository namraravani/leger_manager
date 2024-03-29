import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Components/text_logo.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/invoice.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/GivenPage.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/ReceviedPage.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/small_invoice.dart';

import 'package:lottie/lottie.dart';

class TransactionPage extends StatelessWidget {
  TranscationController transcationcontroller =
      Get.put(TranscationController());
  final String customerName;
  final String contactinfo;
  TransactionPage({
    Key? key,
    required this.customerName,
    required this.contactinfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool yesterdaythere = false;

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
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: transcationcontroller.transcationlist.length,
                itemBuilder: (context, index) {
                  final transaction =
                      transcationcontroller.transcationlist[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: transaction.variable == '1'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (transaction.variable == '1')
                              if (transaction.itemsList?.isNotEmpty ?? true)
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Invoice(
                                            dataList: transaction.itemsList!);
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 260,
                                    width: 250,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.arrow_upward),
                                            Icon(
                                              Icons.currency_rupee_sharp,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              transaction.data,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              transcationcontroller.formatTime(
                                                  transaction.transcationTime),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        // CardGrid(m: 0, n: 1),
                                        Container(
                                          height: 200,
                                          child: SmallInvoice(
                                            dataList: transaction.itemsList!,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_upward),
                                      Icon(
                                        Icons.currency_rupee_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        transaction.data,
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        transcationcontroller.formatTime(
                                            transaction.transcationTime),
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                            else
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_downward),
                                    Icon(
                                      Icons.currency_rupee_sharp,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      transaction.data,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      transcationcontroller.formatTime(
                                          transaction.transcationTime),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              color: Colors.grey[300],
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      onPrimary: Colors.green,
                      minimumSize: Size(120, 40),
                    ),
                    onPressed: () {
                      Get.off(ReceviedPage(
                        customerName: customerName,
                        customerInfo: contactinfo,
                      ));
                    },
                    child: IconLogo(
                      icon: Icon(Icons.arrow_downward),
                      name: Text("Recived"),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      onPrimary: Colors.red,
                      minimumSize: Size(120, 40),
                    ),
                    onPressed: () {
                      Get.off((GivenPage(
                        customerName: customerName,
                        customerInfo: contactinfo,
                      )));
                    },
                    child: IconLogo(
                      icon: Icon(Icons.arrow_upward),
                      name: Text("Given"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
