import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/general_txtfld.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Components/submit_button.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/customer_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Customer_Module/test_contact_view.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  CustomerController customercontroller = Get.find<CustomerController>();
  TranscationController transcationcontroller =
      Get.find<TranscationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: customercontroller.customername,
              decoration: InputDecoration(
                  labelText: "Enter Your Name",
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  )),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: customercontroller.customerinfo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Enter Your Phone Number",
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  )),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SubmitButton(
                  onPressed: () async {
                    // Validate customer name
                    String? nameValidationMessage =
                        customercontroller.validateCustomerName(
                            customercontroller.customername.text);

                    // Validate phone number
                    String? phoneValidationMessage =
                        customercontroller.validatePhoneNumber(
                            customercontroller.customerinfo.text);

                    if (nameValidationMessage != null ||
                        phoneValidationMessage != null) {
                      // If any validation error, display error message
                      String errorMessage = '';
                      if (nameValidationMessage != null) {
                        errorMessage += nameValidationMessage + '\n';
                      }
                      if (phoneValidationMessage != null) {
                        errorMessage += phoneValidationMessage;
                      }
                      // Display error message using Snackbar or Toast
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColors.redColor,
                        content: Text(errorMessage),
                      ));
                    } else {
                      // All validations passed, execute logic
                      await customercontroller.postCustomer();
                      int shop_id =
                          await transcationcontroller.getShopId("9427662325");
                      int cust_id = await transcationcontroller
                          .getCustomerID(customercontroller.customerinfo.text);
                      transcationcontroller.maintainRelation(shop_id, cust_id);
                      customercontroller.customername.clear();
                      customercontroller.customerinfo.clear();
                      Get.back();
                    }
                  },
                  buttonText: 'Add Customer',
                ),
                TextButton(
                  onPressed: () {
                    // customercontroller.addCustomer();
                    Get.off(ContactViewPage());
                    // Get.off(CustomerPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors
                              .secondaryColor, // Specify the border color
                          width: 2.0, // Specify the border width
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: IconLogo(
                        icon: Icon(
                          Icons.contact_phone,
                          color: AppColors.secondaryColor,
                        ),
                        name: Text(
                          "Add From Contacts",
                          style: TextStyle(color: AppColors.secondaryColor),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
