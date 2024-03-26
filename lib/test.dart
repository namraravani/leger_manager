import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/CircleAvatar.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class TestPage extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());
  final box = GetStorage();
  bool dataWritten = false;

  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!dataWritten) {
      // _writeToLocalStorage(); // Write to local storage if data is empty
      dataWritten = true;
    }

    return Container(
      width: 100,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () {
                if (customerController.customerlist.isEmpty) {
                  return Text("dagfd");
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: customerController.customerlist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        // Wrap ListTile with Card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () async {},
                              leading: InitialsAvatar(
                                  name: customerController
                                      .customerlist[index].customerName),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(customerController
                                      .customerlist[index].customerName),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
