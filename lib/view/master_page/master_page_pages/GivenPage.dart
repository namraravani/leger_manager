import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';

class GivenPage extends StatelessWidget {
  TranscationController transcationcontroller =
      Get.find<TranscationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Given Page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: transcationcontroller.data,
            decoration: InputDecoration(labelText: "Enter Data"),
          ),
          ElevatedButton(
            onPressed: () {
              if (transcationcontroller.data.text.isNotEmpty) {
                transcationcontroller.transcationlist.add(Transcation(
                    data: transcationcontroller.data.text, variable: 1));

                transcationcontroller.data.clear();
                transcationcontroller.displaylist();
              }
            },
            child: Text("Add"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
