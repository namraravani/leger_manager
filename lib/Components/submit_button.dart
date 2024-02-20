import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const SubmitButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor),
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
