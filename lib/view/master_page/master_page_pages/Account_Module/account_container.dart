import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class AccountContainer extends StatelessWidget {
  final Widget icon1;
  final Widget icon2;
  final Widget title;
  final Widget details;
  final Color color;

  const AccountContainer({
    required this.icon1,
    required this.icon2,
    required this.title,
    required this.details,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon1,
                SizedBox(width: 10), // Add spacing between icons
              ],
            ),
            SizedBox(height: 10),
            title,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon2,
                details,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
