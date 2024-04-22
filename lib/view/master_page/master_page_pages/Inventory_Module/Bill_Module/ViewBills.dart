import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Components/text_logo.dart';
import 'package:leger_manager/Controller/view_bill_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Bill_Module/ViewInvoice.dart';

class ViewBill extends StatelessWidget {
  ViewBill({Key? key}) : super(key: key);

  final ViewBillController viewBillController = Get.put(ViewBillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Bill"),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: viewBillController.viewBillList.length,
                itemBuilder: (context, index) {
                  final billItem = viewBillController.viewBillList[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ViewInvoice(
                            dataList: billItem.items,
                            amount: billItem.amount,
                            date: billItem.transactionDate
                                .toString()
                                .split(' ')[0],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          child: SvgPicture.asset(
                                            'assets/icon/payment.svg', // Replace 'my_icon.svg' with the path to your SVG file
                                            width:
                                                24, // Adjust the width as needed
                                            height:
                                                24, // Adjust the height as needed
                                            // color: AppColors
                                            //     ., // Adjust the color as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Bill-${index + 1}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 18,
                                          color: AppColors.greenColor,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${billItem.customerId}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    IconLogo(
                                      icon: Icon(
                                        Icons.currency_rupee_sharp,
                                        size: 20,
                                      ),
                                      name: Text(
                                        "${billItem.amount}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${billItem.transactionDate.toString().split(' ')[0]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
