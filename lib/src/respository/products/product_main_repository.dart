import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/network/network_service_api.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/urls/api_urls.dart';

class ProductMainRepository {
  final _networkServiceApi = NetworkServiceApi();

  Future<ProductDataModel> getHomePageProducts({int? limit, int? skip}) async {
    try {
      final url =
          "${ApiUrls.getProducts}${limit != null ? "&limit=$limit" : ""}${skip != null ? "&skip=$skip" : ""}&select=thumbnail,title,rating,availabilityStatus,price,discountPercentage,images";
      var response = await _networkServiceApi.getApi(url);
      return ProductDataModel.fromMap(response);
    } on Failure catch (error) {
      throw Failure(error.message);
    }
  }

  Future<List<Product>> getCategorizedProducts(String apiName) async {
    try {
      final url = "${ApiUrls.getCategoryProduct}/$apiName";
      var response = await _networkServiceApi.getApi(url);
      return (response["products"] as List)
          .map((e) => Product.fromMap(e as Map<String, dynamic>))
          .toList();
    } on Failure catch (error) {
      throw Failure(error.message);
    }
  }

  Future<List<Product>> getSearchedProduct(String searchText) async {
    try {
      final url = "${ApiUrls.searchProduct}$searchText";
      var response = await _networkServiceApi.getApi(url);
      return (response["products"] as List)
          .map((e) => Product.fromMap(e as Map<String, dynamic>))
          .toList();
    } on Failure catch (error) {
      throw Failure(error.message);
    }
  }
}
