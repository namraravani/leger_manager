import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';

class ReceviedPage extends StatefulWidget {
  const ReceviedPage({Key? key}) : super(key: key);

  @override
  _ReceviedPageState createState() => _ReceviedPageState();
}

class _ReceviedPageState extends State<ReceviedPage> {
  TranscationController transcationcontroller =
      Get.find<TranscationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ajfasjfsn"),
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
                    data: transcationcontroller.data.text, variable: 0));

                transcationcontroller.data.clear();
                transcationcontroller.displaylist();

                setState(() {});
              }
            },
            child: Text("Add"),
          ),
          SizedBox(height: 20),
          // Display the list
        ],
      ),
    );
  }
}
