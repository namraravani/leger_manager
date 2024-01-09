import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Item In Inventory to Avoid Hasslefree process of bill making",
                  style: TextStyle(fontSize: 20),
                ),
                Lottie.asset(
                  'assets/animations/inventory_page_animation.json',
                  height: 250,
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
