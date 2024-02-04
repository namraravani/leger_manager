import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/Transcation.dart';

class TranscationController extends GetxController {
  RxList<Transcation> transcationlist = <Transcation>[].obs;
  TextEditingController data = TextEditingController();
  TextEditingController variable = TextEditingController();

  void displaylist() {
    for (int i = 0; i < transcationlist.length; i++) {
      print(transcationlist[i].data);
    }
  }
}
