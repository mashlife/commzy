// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commzy/src/models/product/product_datamodel.dart';

class CartDetailsModel {
  int? quantity;
  Product? product;
  DateTime? createdAt;
  CartDetailsModel({this.quantity, this.product, this.createdAt});

  CartDetailsModel copyWith({
    int? quantity,
    Product? product,
    DateTime? createdAt,
  }) {
    return CartDetailsModel(
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  CartDetailsModel addAnotherToCart() {
    return CartDetailsModel(
      quantity: quantity! + 1,
      product: product,
      createdAt: DateTime.now(),
    );
  }

  CartDetailsModel removeFromCart() {
    return CartDetailsModel(
      quantity: quantity! - 1,
      product: product,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product': product?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory CartDetailsModel.fromMap(Map<String, dynamic> map) {
    return CartDetailsModel(
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      product:
          map['product'] != null
              ? Product.fromMap(map['product'] as Map<String, dynamic>)
              : null,
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : null,
    );
  }

  @override
  String toString() =>
      'CartDetailsModel(quantity: $quantity, product: $product, createdAt: $createdAt)';

  @override
  bool operator ==(covariant CartDetailsModel other) {
    if (identical(this, other)) return true;

    return other.quantity == quantity &&
        other.product == product &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => quantity.hashCode ^ product.hashCode ^ createdAt.hashCode;
}
