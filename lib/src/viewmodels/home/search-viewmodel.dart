import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/respository/products/product_main_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewmodel extends GetxController {
  final _productMainRepo = ProductMainRepository();

  TextEditingController searchText = TextEditingController();
  RxList<Product> searchedProducts = <Product>[].obs;
  Rx<UiStatus> uiStatus = UiStatus.initial.obs;
  RxString message = ''.obs;

  Future<RxList<Product>> getSearchedProducts({
    required String searchString,
  }) async {
    try {
      uiStatus.value = UiStatus.loading;
      final response = await _productMainRepo.getSearchedProduct(searchString);
      uiStatus.value = UiStatus.success;
      searchedProducts.value = response;
    } on Failure catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.message;
      debugPrint('Failure on fetch main products: ${error.message}');
    } catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.toString();
      debugPrint('Error on fetch main products data: $error');
    }
    return searchedProducts;
  }
}
