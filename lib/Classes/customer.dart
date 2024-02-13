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
}
