import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SupplierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
    );
  }
}
