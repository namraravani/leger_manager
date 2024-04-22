import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:leger_manager/Classes/Bill.dart';
import 'package:leger_manager/Classes/Transcation.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';

class ViewBillController extends GetxController {
  RxList<BillItem> viewBillList = <BillItem>[].obs;
  RxList<Transcation> transcationList = <Transcation>[].obs;

  @override
  void onInit() async {
    fetchAndAddBillItems(await getShopId("9427662325"));
    super.onInit();
  }

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

  Future<void> fetchAndAddBillItems(int shopId) async {
    print("Hello I am in the Function");
    // Assuming the API endpoint to fetch data for a specific shop
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/shopbills';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "shop_id": shopId,
        }),
      );

      if (response.statusCode == 200) {
        // Decode the response body bytes
        String responseBody = utf8.decoder.convert(response.bodyBytes);

        // Parse the JSON response
        List<dynamic> jsonData = json.decode(responseBody);

        print(jsonData);

        // Iterate through each object and create BillItem instances
        jsonData.forEach((item) {
          // Check if there are items in the current transaction
          List<InventoryData> itemsList = [];
          if (item['items'] != null) {
            var itemList = item['items'] as List;
            itemsList = itemList
                .map((item) => InventoryData.fromJson(item))
                .cast<InventoryData>() // cast to InventoryData
                .toList();
          }

          // Add the bill item only if itemsList has something inside
          if (itemsList.isNotEmpty) {
            BillItem billItem = BillItem(
              customerId: item['customerid'] ?? 0,
              transactionDate: DateTime.parse(item['transactiondate'] ?? ''),
              amount: double.parse(item['amount'] ?? '0'),
              transactionType: int.parse(item['transactiontype'] ?? '0'),
              items: itemsList,
            );
            viewBillList.add(billItem);
            print(viewBillList);
          }
        });
      } else {
        print('Failed to load bill items: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
