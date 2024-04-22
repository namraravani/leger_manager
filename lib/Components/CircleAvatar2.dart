import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialsAvatar2 extends StatelessWidget {
  final String name;
  static const String colorKey = 'avatarColor';
  static const Color defaultColor =
      Colors.blue; // Default color if no color is stored
  Color? cachedRandomColor;

  InitialsAvatar2({required this.name});

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(name);

    if (cachedRandomColor == null) {
      cachedRandomColor = fetchStoredColor() ?? getRandomColor();
      storeColor(cachedRandomColor!);
    }

    return CircleAvatar(
      radius: 80,
      backgroundColor: cachedRandomColor,
      child: Text(
        initials,
        style: TextStyle(color: Colors.white, fontSize: 80),
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

  Color? fetchStoredColor() {
    SharedPreferences? prefs;
    Color? storedColor;

    getStorageInstance().then((value) {
      prefs = value;
      int? storedColorValue = prefs?.getInt(colorKey);
      storedColor = storedColorValue != null ? Color(storedColorValue) : null;
    });

    return storedColor;
  }

  Future<void> storeColor(Color color) async {
    SharedPreferences prefs = await getStorageInstance();
    prefs.setInt(colorKey, color.value);
  }

  Future<SharedPreferences> getStorageInstance() async {
    return await SharedPreferences.getInstance();
  }
}
