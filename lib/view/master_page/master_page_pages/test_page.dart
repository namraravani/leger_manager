import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text("ajfnasfa"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("ajfnasfa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
