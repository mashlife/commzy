import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/reusable/main-loading.dart';
import 'package:commzy/src/respository/products/product_details_repository.dart';
import 'package:commzy/src/utils/nav-utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsViewModel extends GetxController {
  final _productDetailsRepo = ProductDetailsRepository();

  Rx<UiStatus> uiStatus = UiStatus.initial.obs;
  RxString message = ''.obs;
  Rx<Product>? product;
  RxInt carouselCurrentIndex = 0.obs;

  Future<Rx<Product>?> getProductById(
    BuildContext context, {
    required int id,
  }) async {
    try {
      mainLoading(context);
      uiStatus.value = UiStatus.loading;
      final response = await _productDetailsRepo.getProductById(id: id);

      uiStatus.value = UiStatus.success;
      product = response.obs;
    } on Failure catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.message;
      debugPrint('Failure on fetch product details: ${error.message}');
    } catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.toString();
      debugPrint('Error on fetch product details: $error');
    } finally {
      NavUtils.remove();
    }
    return product;
  }

  updateCarouselIndex(int index) {
    carouselCurrentIndex.value = index;
  }

  void clearProduct() {
    product = null;
    uiStatus.value = UiStatus.initial;
  }
}
