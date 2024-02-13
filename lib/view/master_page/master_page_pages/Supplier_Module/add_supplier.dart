import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/Controller/supplier_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Supplier_Module/contact_view_supplier.dart';

class SupplierAddPage extends StatelessWidget {
  SupplierAddPage({super.key});
  TranscationController transcationcontroller =
      Get.find<TranscationController>();
  @override
  Widget build(BuildContext context) {
    SupplierController suppliercontroller = Get.put(SupplierController());
    return Scaffold(
      appBar: AppBar(
        title: Text('SupplierAdd'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: suppliercontroller.supplier_name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: suppliercontroller.supplier_contact_info,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    int shop_id =
                        await transcationcontroller.getShopId("9427662325");
                    suppliercontroller.postSupplier(shop_id);
                    
                    transcationcontroller.maintainRelation(
                        await transcationcontroller.getShopId("9427662325"),
                        await transcationcontroller.getCustomerID(
                            suppliercontroller.supplier_contact_info.text));
                  },
                  child: Text('Add Supplier'),
                ),
                TextButton(
                  onPressed: () {
                    // customercontroller.addCustomer();
                    // Get.off(ContactViewPage());
                    Get.off(SupplierViewPage());
                  },
                  child: IconLogo(
                      icon: Icon(Icons.contact_phone),
                      name: Text("Add From Contacts")),
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
