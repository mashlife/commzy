import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/models/category/category_model.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/reusable/main-loading.dart';
import 'package:commzy/src/respository/products/product_main_repository.dart';
import 'package:commzy/src/utils/nav-utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewmodel extends GetxController {
  final _productMainRepo = ProductMainRepository();

  Rx<UiStatus> uiStatus = UiStatus.initial.obs;
  RxString message = ''.obs;
  RxBool showStock = false.obs;
  Rx<ProductDataModel>? products;
  Rx<CategoryModel>? categoryModel;
  RxList<Product> categorizedProducts = <Product>[].obs;

  void updateCategoryModel(CategoryModel categoryModel, BuildContext context) {
    this.categoryModel = categoryModel.obs;
    getCategorizedProducts(context, categoryModel.slug!);
  }

  void removeCategoryModel() {
    categoryModel = null;
    categorizedProducts = <Product>[].obs;
  }

  Future<Rx<ProductDataModel>?> getProducts(
    BuildContext context, {
    int? limit,
    int? skip,
  }) async {
    try {
      mainLoading(context);
      uiStatus.value = UiStatus.loading;
      final response = await _productMainRepo.getHomePageProducts(
        limit: limit,
        skip: skip,
      );

      if (response.products != null && response.products!.isNotEmpty) {
        uiStatus.value = UiStatus.success;
        products = response.obs;
      } else {
        uiStatus.value = UiStatus.failed;
        message.value = response.toJson();
      }
    } on Failure catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.message;
      debugPrint('Failure on fetch main products: ${error.message}');
    } catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.toString();
      debugPrint('Error on fetch main products data: $error');
    } finally {
      print(uiStatus.value);
      NavUtils.remove();
    }
    return products;
  }

  Future<RxList<Product>> getCategorizedProducts(
    BuildContext context,
    String slug,
  ) async {
    try {
      mainLoading(context);
      uiStatus.value = UiStatus.loading;
      final response = await _productMainRepo.getCategorizedProducts(slug);
      uiStatus.value = UiStatus.success;
      categorizedProducts = response.obs;
    } on Failure catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.message;
      debugPrint('Failure on fetch main products: ${error.message}');
    } catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.toString();
      debugPrint('Error on fetch main products data: $error');
    } finally {
      print(uiStatus.value);
      NavUtils.remove();
    }
    return categorizedProducts;
  }
}
