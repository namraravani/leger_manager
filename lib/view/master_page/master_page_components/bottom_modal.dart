import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/view/profile_page.dart';

class CustomBottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      height: 150,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.person,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: IconLogo(
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.secondaryColor,
                  ),
                  name: Text(
                    "Edit Profile",
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
                onPressed: () {
                  Get.to(ProfilePage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
