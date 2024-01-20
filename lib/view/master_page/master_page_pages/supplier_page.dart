import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/view/contact_view.dart';
import 'package:leger_manager/view/test_contact_view.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SupplierPage extends StatelessWidget {
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
                    'assets/animations/supplier_page.json',
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
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () async {
                Get.to(TestContactApp());
              },
              child: Icon(Icons.person_add_alt_1),
            ),
          ),
        ],
      ),
    );
  }
}
