import 'package:flutter/material.dart';

class IconLogo extends StatelessWidget {
  final Icon icon;
  final Text name;
  const IconLogo({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        name,
      ],
    );
  }
}
