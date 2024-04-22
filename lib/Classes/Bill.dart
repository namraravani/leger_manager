import 'dart:convert';

import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';

class BillItem {
  int customerId;
  DateTime transactionDate;
  double amount;
  int transactionType;
  List<InventoryData> items;

  BillItem({
    required this.customerId,
    required this.transactionDate,
    required this.amount,
    required this.transactionType,
    required this.items,
  });

  factory BillItem.fromJson(Map<String, dynamic> json) {
    List<InventoryData> itemsList = [];
    if (json['items'] != null) {
      var itemList = json['items'] as List;
      itemsList = itemList.map((item) => InventoryData.fromJson(item)).toList();
    }

    return BillItem(
      customerId: json['customerid'] ?? 0,
      transactionDate: DateTime.parse(json['transactiondate'] ?? ''),
      amount: double.parse(json['amount'] ?? '0'),
      transactionType: json['transactiontype'] ?? 0,
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJsonList = [];
    itemsJsonList = items.map((item) => item.toJson()).toList();

    return {
      'customerid': customerId,
      'transactiondate': transactionDate.toIso8601String(),
      'amount': amount,
      'transactiontype': transactionType,
      'items': itemsJsonList,
    };
  }
}