import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:leger_manager/Controller/dependency_injection.dart';
import 'package:leger_manager/Controller/network_controller.dart';
import 'package:leger_manager/test.dart';
import 'package:leger_manager/test1.dart';
import 'package:leger_manager/view/check_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:leger_manager/view/login_page.dart';
import 'package:leger_manager/view/master_page/master_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Account_Module/account_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  Dependencyinjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
