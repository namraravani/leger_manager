import 'package:flutter/services.dart';

/// Global function to generate input formatters with common validation rules.
List<TextInputFormatter> getCommonInputFormatters() {
  return [
    FilteringTextInputFormatter.deny(RegExp(r'[,\-\s]')), // Deny comma, hyphen, and space
  ];
}
