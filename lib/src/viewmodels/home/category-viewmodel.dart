import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/models/category/category_model.dart';
import 'package:commzy/src/respository/category/category_main_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  final _categoryMainRepo = CategoryMainRepository();

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<UiStatus> uiStatus = UiStatus.initial.obs;
  RxString message = ''.obs;

  Future<Rx<CategoryModel>?> getCategories(BuildContext context) async {
    try {
      uiStatus.value = UiStatus.loading;
      final response = await _categoryMainRepo.getHomePageCategories();

      uiStatus.value = UiStatus.success;
      categories = response.obs;
    } on Failure catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.message;
      debugPrint('Failure on fetch categories: ${error.message}');
    } catch (error) {
      uiStatus.value = UiStatus.error;
      message.value = error.toString();
      debugPrint('Error on fetch categories data: $error');
    }
    return null;
  }
}
