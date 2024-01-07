import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
          // FloatingActionButton(onPressed: () {}, child: Icon(Icons.abc))
        ],
      ),
    );
  }
}
