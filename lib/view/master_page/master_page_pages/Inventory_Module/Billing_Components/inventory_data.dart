class InventoryData {
  String? abc;
  String? category;
  String? product;
  int? quantity;
  double? total_price; 

  InventoryData({this.abc, this.category, this.product,this.quantity, this.total_price});

  factory InventoryData.fromJson(Map<String, dynamic> json) {
    return InventoryData(
      total_price: (json['price'] ?? 0).toDouble(),
      abc: json['company'] ?? '',
      product: json['product'] ?? '',
      category: json['category'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abc': abc,
      'category': category,
      'product': product,
      'quantity': quantity,
      'total_price': total_price,
    };
  }
}
