part of 'init_dependency.dart';

class InjectDependency {
  static Future<void> injectDep() async {
    ProductViewmodel productViewmodel = Get.put(ProductViewmodel());
    CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());
    ProductDetailsViewModel productDetailsViewModel = Get.put(
      ProductDetailsViewModel(),
    );
    SearchViewmodel searchViewmodel = Get.put(SearchViewmodel());
    ShopServices shopServices = Get.put(ShopServices());
  }
}
