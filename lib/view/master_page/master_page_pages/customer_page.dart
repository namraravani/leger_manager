import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:lottie/lottie.dart';

class CustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
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
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(200.0, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                
              },
              child: Container(
                width: 200.0,
                child: IconLogo(
                  icon: Icon(
                    Icons.person_add_alt_1,
                    color: AppColors.secondaryColor,
                  ),
                  name: Text(
                    "Add From Contacts",
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
