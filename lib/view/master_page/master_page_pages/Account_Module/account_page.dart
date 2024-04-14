import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/account_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_detail_page.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountController accountcontroller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
      ),
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(AccountDetailPage());
                  },
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(
                          color: AppColors.secondaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.book,
                              size: 30,
                            ),
                            Text(
                              "Net Balance",
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_circle_right_outlined),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Customer Khata"),
                            Spacer(),
                            Text(
                              "${accountcontroller.totalAmount}",
                              style: TextStyle(color: AppColors.greenColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            Text("Customers"),
                            Spacer(),
                            Text("You Give"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 400,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.book,
                            size: 30,
                          ),
                          Text(
                            "Net Balance",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_circle_right_outlined),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Supplier Khata"),
                          Spacer(),
                          Text(
                            accountcontroller.totaladvanceamt.value,
                            style: TextStyle(color: AppColors.greenColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text("Customers"),
                          Spacer(),
                          Text("You Give"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
