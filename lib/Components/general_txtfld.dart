import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class GeneralTxtfld extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;

  const GeneralTxtfld({
    required this.hintText,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
          )),
    );
  }
}
