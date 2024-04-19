import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/view/profile_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(ProfilePage());
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.person,
                  color: AppColors.secondaryColor,
                  size: 50,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(
                      Icons.blinds_closed_sharp,
                      color: AppColors.secondaryColor,
                    ),
                    name: Text(
                      "Statement",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(
                      Icons.help,
                      color: AppColors.secondaryColor,
                    ),
                    name: Text(
                      "Help",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(
                      Icons.more,
                      color: AppColors.secondaryColor,
                    ),
                    name: Text(
                      "About",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.secondaryColor,
                    ),
                    name: Text(
                      "Settings",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(
                      Icons.share,
                      color: AppColors.secondaryColor,
                    ),
                    name: Text(
                      "Share",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
