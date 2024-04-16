import 'dart:convert';

class AllCustomer {
  final int customerId;
  final String name;
  final String contactInfo;
  final int type;

  AllCustomer({
    required this.customerId,
    required this.name,
    required this.contactInfo,
    required this.type,
  });

  factory AllCustomer.fromJson(Map<String, dynamic> json) {
    return AllCustomer(
      customerId: json['customerid'],
      name: json['name'],
      contactInfo: json['contactinfo'],
      type: json['type'],
    );
  }
}

List<AllCustomer> parseCustomers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<AllCustomer>((json) => AllCustomer.fromJson(json)).toList();
}
