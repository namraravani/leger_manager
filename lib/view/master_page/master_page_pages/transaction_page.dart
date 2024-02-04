import 'package:flutter/material.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:lottie/lottie.dart';

class TransactionPage extends StatelessWidget {
  final String customerName;
  final String contactinfo;
  const TransactionPage({
    Key? key,
    required this.customerName,
    required this.contactinfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InitialsAvatar(name: customerName),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  customerName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Text(
                  "View Profile",
                  style: TextStyle(fontSize: 14, color: Colors.indigoAccent),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Transaction Between You",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "And Customer are Secure",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.lock),
                  ],
                ),
              ],
            ),
            Image.asset(
              'assets/image/transcation.png',
              height: 250,
              fit: BoxFit.cover,
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            color: Colors.grey[300],
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    onPrimary: Colors.green,
                    minimumSize: Size(120, 40),
                  ),
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(Icons.arrow_downward),
                    name: Text("Recived"),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    onPrimary: Colors.red,
                    minimumSize: Size(120, 40),
                  ),
                  onPressed: () {},
                  child: IconLogo(
                    icon: Icon(Icons.arrow_upward),
                    name: Text("Given"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
