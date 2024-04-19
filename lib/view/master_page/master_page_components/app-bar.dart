import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';

import 'package:leger_manager/view/master_page/master_page_components/bottom_modal.dart';
import 'package:leger_manager/view/master_page/master_page_components/search_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_page.dart';
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
              Scaffold.of(context).openDrawer();
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
              child: GestureDetector(
                onTap: () {
                  Get.to(() => SearchPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.search_sharp,
                        color: AppColors.secondaryColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
          ),
          GestureDetector(
            onTap: () {
              Get.to(AccountPage());
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
