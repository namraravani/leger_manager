import 'package:flutter/material.dart';

class TextLogo extends StatelessWidget {
  final String ImageUrl;
  final Text name;
  const TextLogo({
    super.key,
    required this.ImageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(ImageUrl),
          height: 50,
          width: 50,
        ),
        name,
      ],
    );
  }
}
