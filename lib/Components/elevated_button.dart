import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: AppColors.secondaryColor,
            width: 1,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
