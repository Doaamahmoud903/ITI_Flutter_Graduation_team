class AddCartModel {
  final String message;
  final Cart cart;
  final bool success;

  AddCartModel({
    required this.message,
    required this.cart,
    required this.success,
  });

  factory AddCartModel.fromJson(Map<String, dynamic> json) {
    return AddCartModel(
      message: json['message'],
      cart: Cart.fromJson(json['cart']),
      success: json['success'] ?? false,
    );
  }
}

class Cart {
  final String user;
  final List<Product> products;
  final String id;
  final int totalCartPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.user,
    required this.products,
    required this.id,
    required this.totalCartPrice,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      user: json['user'],
      products: List<Product>.from(
        json["products"].map((x) => Product.fromJson(x)),
      ),
      id: json["_id"],
      totalCartPrice: json["totalCartPrice"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}

class Product {
  final String productId;
  final int quantity;
  final int price;
  final String id;

  Product({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.id,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["productId"],
      quantity: json["quantity"],
      price: json["price"],
      id: json["_id"],
    );
  }
}
