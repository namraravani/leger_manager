
import 'dart:math';
import 'dart:ui';

Color getRandomColor() {
  
  Random random = Random();
  int r = random.nextInt(256);
  int g = random.nextInt(256);
  int b = random.nextInt(256);

  
  return Color.fromARGB(255, r, g, b);
}