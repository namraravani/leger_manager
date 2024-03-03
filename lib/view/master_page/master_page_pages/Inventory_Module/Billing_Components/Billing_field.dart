import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class BillingField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final List<String> dropdownItems;
  final ValueChanged<String?> onDataChanged;
  final int? index;

  BillingField({
    required this.icon,
    required this.hintText,
    required this.dropdownItems,
    required this.onDataChanged,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 205,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: null,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                items: dropdownItems.asMap().entries.map((entry) {
                  int entryIndex = entry.key;
                  String item = entry.value;
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onDataChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
