class Product {
  final String? id;
  final String name;
  final double price;
  final String description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      id: data["_id"] as String?,
      name: data['name'] as String,
      price: (data['price'] as num).toDouble(),
      description: data['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
