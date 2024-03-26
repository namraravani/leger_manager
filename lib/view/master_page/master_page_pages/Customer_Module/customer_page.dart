import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';

import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/Controller/test_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/Customer_add.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/test_contact_view.dart';
import 'package:lottie/lottie.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TranscationController transactioncontroller =
      Get.put(TranscationController());

  final CustomerController customercontroller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await customercontroller.getCustomer();
              await customercontroller.loadLastTransactionDataForCustomers(
                  customercontroller.customerlist);
            },
            child: buildCustomerListView(),
          ),
          Positioned(
            bottom: 16.0,
            right: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () async {
                    Get.to(CustomerListPage());
                  },
                  child: Icon(Icons.person_add_alt_1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomerListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Obx(
        () {
          if (customercontroller.customerlist.isEmpty) {
            return Center(child: buildEmptyListAnimation());
          } else {
            return ListView.builder(
              itemCount: customercontroller.customerlist.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        int shop_id =
                            await transactioncontroller.getShopId("9427662325");
                        int cust_id = await transactioncontroller.getCustomerID(
                            customercontroller.customerlist[index].contactInfo);
                        print(shop_id);
                        transactioncontroller.getAlltranscation(
                            shop_id, cust_id);
                        Get.to(TransactionPage(
                          customerName: customercontroller
                              .customerlist[index].customerName,
                          contactinfo: customercontroller
                              .customerlist[index].contactInfo,
                        ));
                      },
                      leading: InitialsAvatar(
                          name: customercontroller
                              .customerlist[index].customerName),
                      title: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(customercontroller
                                .customerlist[index].customerName),
                            Spacer(),
                            if (customercontroller.totalSumList.isNotEmpty &&
                                index < customercontroller.totalSumList.length)
                              Text("${customercontroller.totalSumList[index]}"),
                          ],
                        ),
                      ),
                      subtitle: Obx(
                        () => Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: 17,
                            ),
                            if (customercontroller
                                    .lastTransactionList.isNotEmpty &&
                                index <
                                    customercontroller
                                        .lastTransactionList.length)
                              Text(
                                customercontroller
                                    .lastTransactionList[index].data,
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            SizedBox(width: 5),
                            if (customercontroller
                                    .lastTransactionList.isNotEmpty &&
                                index <
                                    customercontroller
                                        .lastTransactionList.length)
                              Text(
                                  "Payment added on ${customercontroller.formatDateTime(customercontroller.lastTransactionList[index].transcationTime)}"),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildEmptyListAnimation() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Start Your Journey with Ledger Manager"),
            Lottie.asset(
              'assets/animations/start_page_animation.json',
              height: 250,
              reverse: true,
              repeat: true,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
