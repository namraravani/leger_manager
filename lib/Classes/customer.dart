class Customer {
  String customerName;
  String contactInfo;

  // Named parameters in the constructor
  Customer({required this.customerName, required this.contactInfo});

  // Factory method to create a Customer from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      // Use named keys from the JSON
      customerName: json['name'] ?? '',
      contactInfo: json['contactinfo'] ?? '',
    );
  }
}
