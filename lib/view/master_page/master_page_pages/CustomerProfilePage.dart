import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Components/CircleAvatar2.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/customer_profile_controller.dart';

class CustomerProfilePage extends StatefulWidget {
  CustomerProfilePageController customerProfilePage =
      Get.put(CustomerProfilePageController());
  final String customerName;
  final String contactInfo;

  CustomerProfilePage({
    Key? key,
    required this.customerName,
    required this.contactInfo,
  }) : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  bool _buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InitialsAvatar2(
              name: widget.customerName,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Customer Name",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.customerName,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Customer Number",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.contactInfo,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buttonClicked
                ? Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.compare_arrows,
                            size: 40,
                            color: AppColors.secondaryColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Move To Supplier",
                            style: TextStyle(
                              fontSize: 30,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        _buttonClicked = true;
                      });
                      widget.customerProfilePage
                          .MoveCustomer(widget.contactInfo);
                    },
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.secondaryColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.compare_arrows,
                              size: 40,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Move To Supplier",
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
