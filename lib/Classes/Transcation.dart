import 'package:leger_manager/view/master_page/master_page_pages/Inventory_Module/Billing_Components/inventory_data.dart';

class Transcation {
  final String data;
  final String variable;
  final String transcationTime;
  final List<InventoryData>? itemsList; // Changed variable name

  Transcation({
    required this.data,
    required this.variable,
    required this.transcationTime,
    this.itemsList,
  });

  factory Transcation.fromJson(Map<String, dynamic> json) {
    List<dynamic>? jsonItems = json['items'];
    List<InventoryData>? itemsList;

    if (jsonItems != null) {
      itemsList = jsonItems
          .map((item) => InventoryData.fromJson(item))
          .toList()
          .cast<InventoryData>();
    }

    return Transcation(
      data: json['amount'] ?? '0', // Changed type to String
      variable: json['transactiontype'] ?? '',
      transcationTime: json['transactiondate'] ?? '',
      itemsList: itemsList,
    );
  }
}