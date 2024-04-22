import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:http/http.dart' as http;
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/billing_controller.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:share_plus/share_plus.dart';

class TranscationController extends GetxController {
  RxList<Transcation> transcationlist = <Transcation>[].obs;
  TextEditingController data = TextEditingController();
  TextEditingController variable = TextEditingController();
  RxString mobileNumber = ''.obs;
  RxString contactinfo = ''.obs;
  

  final CustomerController customerController = Get.put(CustomerController());
  final BillingController billingController = Get.put(BillingController());

  @override
  void setMobileNumber(String number) {
    mobileNumber.value = number;
  }

  String _customerInfo = '';

  void setCustomerInfo(String customerInfo) {
    _customerInfo = customerInfo;
  }

  String get customerInfo => _customerInfo;

  Future<int> getShopId(String yourStringData) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/getshopid';

    try {
      print(yourStringData);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contactinfo": yourStringData,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        int shopId = responseData['shopId'];
        print(shopId);
        return shopId;
      } else {
        throw Exception(
            'Failed to get shopId. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  String formatTime(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);

      String formattedTime = DateFormat('h:mm a').format(originalTime);

      return formattedTime;
    } catch (e) {
      return "Invalid Time";
    }
  }

  String formatDate(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);
      String formattedDate = DateFormat('yyyy-MM-dd').format(originalTime);
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "Invalid Date";
    }
  }

  DateTime DisplayDay(String originalTimeString) {
    try {
      DateTime originalTime = DateTime.parse(originalTimeString);
      // String formattedDate = DateFormat('yyyy-MM-dd').format(originalTime);
      return originalTime;
    } catch (e) {
      print("Error formatting date: $e");
      return DateTime.now();
    }
  }

  Future<int> getCustomerID(String yourStringData) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchcustomerid';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contactinfo": yourStringData,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        int customer_id = responseData['customerId'];

        return customer_id;
      } else {
        throw Exception(
            'Failed to get customer id. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> maintainRelation(int shop_id, int customerid) async {
    try {
      // Replace with your actual value
      // int customer_id = await getCustomerID(_customerInfo);

      Map<String, dynamic> customerData = {
        "custid": customerid,
        "shop_id": shop_id,
      };

      String jsonData = json.encode(customerData);

      // print("Hello I am heree this i s afa Shop Id" + "${shop_id}");

      const apiUrl =
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/insertRelation';

      final response = await http.post(Uri.parse(apiUrl), body: jsonData);

      if (response.statusCode == 200) {
        print('Relation inserted successfully: ${response.body}');
      } else {
        print(
            'Error while ajgnsjgndgjdsngsdjnsdkjfnk inserting relation: ${response.statusCode}');
      }
    } catch (error) {}
  }

  void postTranscation(
      String shopid, String customer_id, num amt, String type) async {
    try {
      if (shopid.isEmpty || customer_id.isEmpty || type.isEmpty) {
        print("Empty Data");
        return;
      }

      Map<String, dynamic> customerData = {
        'customerid': customer_id,
        'amount': amt,
        'type': type,
        'shopid': shopid,
      };

      String jsonData = json.encode(customerData);

      final response = await http.post(
        Uri.parse(
            'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/createtranscation'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        int intValue1 = int.parse(shopid);
        int intValue2 = int.parse(customer_id);
        getAlltranscation(intValue1, intValue2);

        customerController.getCustomer();
      } else {
        print('Error adding customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void getAlltranscation(int shopid, int customer_id) async {
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/gettranscationbyid';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "custid": customer_id,
          "shop_id": shopid,
        }),
      );

      if (response.statusCode == 200) {
        transcationlist.clear();
        final List<dynamic> jsonData = json.decode(response.body);

        List<Transcation> transcationList = jsonData
            .map((transaction) => Transcation.fromJson(transaction))
            .toList();

        transcationlist.assignAll(transcationList);
      } else {
        print(
            "Failed to get transactions. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> launchWhatsAppMessage(String contactinfo, String transactionData,
      String transactionTime) async {
    try {
      // Check if the contact number starts with "+91", if so, remove it
      String contactWithoutPrefix = contactinfo.startsWith('+91')
          ? contactinfo.substring(3)
          : contactinfo;
      String transcationTime = formatDateTime(transactionTime);
      // Construct the WhatsApp URL with the modified contact number
      var url =
          'https://wa.me/+91$contactWithoutPrefix?text=${Uri.encodeComponent("You Have Given $transactionData at this $transcationTime")}';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  String formatDateTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('ddMMM,y');
    return formatter.format(dateTime);
  }

  Future<void> shareFileToWhatsapp(
      int transid,
      String customerName,
      String contactInfo,
      String transactionTime,
      List<InventoryData> inventoryDataList) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  buildHeader(customerName, contactInfo, transactionTime),
                  pw.SizedBox(height: 20),
                  buildTable(inventoryDataList),
                ]),
          ];
        },
      ),
    );

    final pdfBytes = await pdf.save();

    final filePath = '/storage/emulated/0/Download/${transid}Bill.pdf';

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    String contactWithoutPrefix =
        contactInfo.startsWith('+91') ? contactInfo.substring(3) : contactInfo;

    // var url = "whatsapp://send?phone=$contactWithoutPrefix&file=$filePath";

    Share.shareFiles([filePath], text: "This is Your Bill");

    print('PDF Whatsapped successfully');
  }

  Future<void> saveInventoryDataToPdf(
      int transid,
      String customerName,
      String contactInfo,
      String transactionTime,
      List<InventoryData> inventoryDataList) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  buildHeader(customerName, contactInfo, transactionTime),
                  pw.SizedBox(height: 20),
                  buildTable(inventoryDataList),
                ]),
          ];
        },
      ),
    );

    final pdfBytes = await pdf.save();

    final filePath =
        '/storage/emulated/0/Download/${transid}TransactionDetail.pdf';

    // Save PDF document to file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Display success message
    print('PDF saved successfully');
  }

  pw.Widget buildHeader(
          String customername, String customerinfo, String transtime) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(customername),
          pw.Text(customerinfo),
          pw.Text("Invoice"),
          pw.Text("Generated By Ledger Manager"),
          pw.Text("Date :- " + formatDateTime(transtime)),
        ],
      );

  pw.Widget buildTableCell(String text) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10),
      ),
    );
  }

  pw.Widget buildTable(List<InventoryData> inventoryDataList) => pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Table(defaultColumnWidth: pw.FixedColumnWidth(50.0), children: [
            pw.TableRow(
              children: [
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
              ],
            ),
            pw.TableRow(
              children: [
                buildTableCell("Item"),
                buildTableCell("Company"),
                buildTableCell("Category"),
                buildTableCell("Product"),
                buildTableCell("Quantity"),
                buildTableCell("Price"),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
              ],
            ),
            for (int index = 0; index < inventoryDataList.length; index++)
              pw.TableRow(children: [
                buildTableCell("${index + 1}"),
                buildTableCell('${inventoryDataList[index].abc}'),
                buildTableCell('${inventoryDataList[index].category}'),
                buildTableCell('${inventoryDataList[index].product}'),
                buildTableCell('${inventoryDataList[index].quantity}'),
                buildTableCell('${inventoryDataList[index].total_price}'),
              ]),
            pw.TableRow(
              children: [
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
                pw.Divider(),
              ],
            ),
          ]),
          pw.Padding(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total"),
                  pw.Text(
                      "${billingController.calculateTotalPrice(inventoryDataList)}"),
                ],
              )),
        ],
      );
}
