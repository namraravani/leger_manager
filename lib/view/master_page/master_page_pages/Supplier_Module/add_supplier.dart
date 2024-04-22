import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/general_txtfld.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Components/submit_button.dart';
import 'package:leger_manager/Controller/supplier_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Supplier_Module/contact_view_supplier.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Supplier_Module/supplier_page.dart';

class SupplierAddPage extends StatelessWidget {
  SupplierAddPage({super.key});
  TranscationController transcationcontroller =
      Get.find<TranscationController>();
  @override
  Widget build(BuildContext context) {
    SupplierController suppliercontroller = Get.put(SupplierController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Supplier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: suppliercontroller.supplier_name,
              decoration: InputDecoration(
                  hintText: "Namra",
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
              controller: suppliercontroller.supplier_contact_info,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "9427662325",
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
                    String? nameValidationMessage =
                        suppliercontroller.validateCustomerName(
                            suppliercontroller.supplier_name.text);

                    // Validate phone number
                    String? phoneValidationMessage =
                        suppliercontroller.validatePhoneNumber(
                            suppliercontroller.supplier_contact_info.text);

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
                      int shop_id =
                          await transcationcontroller.getShopId("9427662325");
                      await suppliercontroller.postSupplier(shop_id);

                      transcationcontroller.maintainRelation(
                          await transcationcontroller.getShopId("9427662325"),
                          await transcationcontroller.getCustomerID(
                              suppliercontroller.supplier_contact_info.text));

                      await suppliercontroller.getSuppliers(shop_id);

                      suppliercontroller.supplier_name.clear();
                      suppliercontroller.supplier_contact_info.clear();
                      Get.back();
                    }
                  },
                  buttonText: 'Add Supplier',
                ),
                TextButton(
                  onPressed: () {
                    // customercontroller.addCustomer();
                    // Get.off(ContactViewPage());
                    Get.off(SupplierViewPage());
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
