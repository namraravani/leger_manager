import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_container.dart';
// Import the AccountContainer widget

class AccountPageFinal extends StatelessWidget {
  const AccountPageFinal({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Account Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Customer Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: AccountContainer(
                  icon1: Icon(Icons.group,
                      size: 50, color: AppColors.secondaryColor),
                  icon2: Icon(Icons.person,
                      size: 20, color: AppColors.secondaryColor),
                  title: Text(
                    "Total Customers",
                    style: TextStyle(
                        fontSize: 20, color: AppColors.secondaryColor),
                  ),
                  details: Text(
                    "5",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryColor),
                  ),
                  color: AppColors.secondaryColor,
                )),
                Expanded(
                    child: AccountContainer(
                  icon1: Icon(Icons.attach_money,
                      size: 50, color: AppColors.greenColor),
                  icon2: Icon(Icons.currency_rupee_sharp,
                      size: 20, color: AppColors.greenColor),
                  title: Text(
                    "Advnace Amount",
                    style: TextStyle(fontSize: 20, color: AppColors.greenColor),
                  ),
                  details: Text(
                    "3435",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.greenColor),
                  ),
                  color: AppColors.greenColor,
                )),
              ],
            ),
          ),
          Center(
            child: Text(
              "Supplier Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: AccountContainer(
                  icon1: Icon(Icons.group,
                      size: 50, color: AppColors.secondaryColor),
                  icon2: Icon(Icons.person,
                      size: 20, color: AppColors.secondaryColor),
                  title: Text(
                    "Total Suppliers",
                    style: TextStyle(
                        fontSize: 20, color: AppColors.secondaryColor),
                  ),
                  details: Text(
                    "10",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryColor),
                  ),
                  color: AppColors.secondaryColor,
                )),
                Expanded(
                    child: AccountContainer(
                  icon1: Icon(Icons.money_off,
                      size: 50, color: AppColors.redColor),
                  icon2: Icon(Icons.currency_rupee_sharp,
                      size: 20, color: AppColors.redColor),
                  title: Text(
                    "Due Amount",
                    style: TextStyle(fontSize: 20, color: AppColors.redColor),
                  ),
                  details: Text(
                    "3435",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.redColor),
                  ),
                  color: AppColors.redColor,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
