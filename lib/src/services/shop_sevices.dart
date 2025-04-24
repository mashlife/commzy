import 'package:commzy/src/models/cart/cart_details_model.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopServices extends GetxController {
  final RxList<CartDetailsModel> userCart = <CartDetailsModel>[].obs;

  void addProducts(Product product) {
    final index = userCart.indexWhere((p) => p.product!.id == product.id);
    if (index != -1) {
      final modifiedItem = userCart[index];
      userCart[index] = modifiedItem.addAnotherToCart();
    } else {
      userCart.add(
        CartDetailsModel(
          quantity: 1,
          product: product,
          createdAt: DateTime.now(),
        ),
      );
    }
    return;
  }

  void removeProducts(Product product) {
    final index = userCart.indexWhere((p) => p.product!.id == product.id);

    if (index != -1) {
      final modifiedItem = userCart[index];
      if (modifiedItem.quantity == 1) {
        userCart.removeAt(index);
      } else {
        userCart[index] = modifiedItem.removeFromCart();
      }
    } else {
      debugPrint("Product not found in cart");
    }
  }

  int? cartHasProductById(int productId) {
    final index = userCart.indexWhere((p) => p.product!.id == productId);

    if (index != -1) {
      return index;
    }
    return null;
  }
}
