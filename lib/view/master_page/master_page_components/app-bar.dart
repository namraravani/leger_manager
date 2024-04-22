import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';

import 'package:leger_manager/view/master_page/master_page_components/bottom_modal.dart';
import 'package:leger_manager/view/master_page/master_page_components/search_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_page_final.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/inventory_page.dart';
import 'package:leger_manager/view/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              Get.to(ProfilePage());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.person, color: AppColors.secondaryColor),
              ),
            ),
          ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 1.0,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(SearchPage());
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                      width: 3), // Adjust the spacing between the icon and text
                  Text(
                    'Click Here To Search.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15, // Adjust the text color as needed
                    ),
                  ),
                ],
              ),
            ),
          )),
          SizedBox(
            width: 13,
          ),
          GestureDetector(
            onTap: () {
              Get.to(AccountPageFinal());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.inventory, color: AppColors.secondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
