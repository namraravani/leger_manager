import 'dart:convert';

// Define the Customer class
class Customer {
  String customerName;
  String contactInfo;

  Customer({required this.customerName, required this.contactInfo});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerName: json['name'] ?? '',
      contactInfo: json['contactinfo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': customerName,
      'contactinfo': contactInfo,
    };
  }
}