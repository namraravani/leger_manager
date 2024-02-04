import 'dart:math';

import 'package:flutter/material.dart';

class InitialsAvatar extends StatelessWidget {
  final String name;

  InitialsAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(name);
    Color randomColor = getRandomColor();

    return CircleAvatar(
      backgroundColor: randomColor,
      child: Text(
        initials,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
    } else {
      return nameParts[0][0].toUpperCase();
    }
  }

  Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);

    return Color.fromARGB(255, r, g, b);
  }
}
