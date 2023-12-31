import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';

import 'package:leger_manager/Components/text_logo.dart';
import 'package:leger_manager/Controller/login_controller.dart';
import 'package:leger_manager/view/otp_verification_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  late TextLogo selectedValue;
  List<TextLogo> list = [
    TextLogo(ImageUrl: 'assets/image/rock.png', name: Text("Company")),
    TextLogo(ImageUrl: 'assets/image/rock.png', name: Text("gsdgfdfd")),
  ];

  @override
  void initState() {
    super.initState();
    selectedValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLogo(
                  ImageUrl: 'assets/image/rock.png', name: Text("Company")),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: DropdownButton<TextLogo>(
                  iconEnabledColor: Colors.black,
                  value: selectedValue,
                  dropdownColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  icon: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.blue,
                  ),
                  elevation: 23,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<TextLogo>>((TextLogo value) {
                    return DropdownMenuItem<TextLogo>(
                      value: value,
                      child: Row(
                        children: [
                          Image.asset(
                            value.ImageUrl,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          value.name,
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_iphone_rounded,
              size: 50,
            ),
            Text(
              "Enter Your Mobile Number",
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 10,
                    controller: loginController.mobileno,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_outlined),
                        label: Text("Mobile Number"),
                        labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : Colors.blue;
                            return TextStyle(color: color, letterSpacing: 1.3);
                          },
                        ),
                        hintText: 'Enter Your Mobile Number',
                        helperText:
                            'By continuing, you agree to our \nterms & conditions and services',
                        filled: true,
                        fillColor: AppColors.primaryColor,
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                  child: Ink(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: AppColors.primaryColor),
                    child: IconButton(
                      onPressed: () {
                        loginController.addMobileNumber();
                        loginController.mobileno.clear();
                        Get.to(OTPVerification());
                      },
                      icon: Icon(Icons.check),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
