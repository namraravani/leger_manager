import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AccountController extends GetxController {
  RxString totalamt = "hello".obs;
  RxString totaladvanceamt = "hello".obs;
  var rangeDatePickerValue = <DateTime?>[].obs;
  var isRangeLocked = false.obs;

  void lockRange() {
    isRangeLocked.value = true;
  }

  @override
  void onInit() {
    callGetShopId();
    super.onInit();
  }

  Future<void> callGetShopId() async {
    try {
      String yourStringData = '9427662325';

      int shopId = await getShopId(yourStringData);
      totalamt.value = await fetchAndUpdateTotalAmount(shopId);
      totaladvanceamt.value = await fetchAndUpdateTotaladvanceAmount(shopId);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<String> fetchAndUpdateTotalAmount(int shopId) async {
    try {
      String apiUrl =
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/dueamount';

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
        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic>) {
          print("Hello");
          // Assuming the first item in the list is a Map
          final Map<String, dynamic> firstItem = responseData.first;

          String totalAmount = firstItem['total_amount'] ?? '';
          int parsedAmount = int.tryParse(totalAmount) ?? 0;

          print(totalAmount);

          return totalAmount;
        } else if (responseData is Map<String, dynamic>) {
          String totalAmount = responseData['total_amount'] ?? '';

          return totalAmount; // Trigger a UI update
        } else {
          return "No amount found";
        }
      } else {
        return "No amount found";
      }
    } catch (error) {
      return "No amount found";
    }
  }

  Future<String> fetchAndUpdateTotaladvanceAmount(int shopId) async {
    try {
      String apiUrl =
          'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/advanceamount';

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
        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic>) {
          print("Hello");
          // Assuming the first item in the list is a Map
          final Map<String, dynamic> firstItem = responseData.first;

          String totalAmount = firstItem['total_amount'] ?? '';
          int parsedAmount = int.tryParse(totalAmount) ?? 0;

          print(totalAmount);

          return totalAmount;
        } else if (responseData is Map<String, dynamic>) {
          String totalAmount = responseData['total_amount'] ?? '';

          return totalAmount; // Trigger a UI update
        } else {
          return "No amount found";
        }
      } else {
        return "No amount found";
      }
    } catch (error) {
      return "No amount found";
    }
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
}
