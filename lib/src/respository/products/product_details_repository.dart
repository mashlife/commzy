import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/network/network_service_api.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/urls/api_urls.dart';

class ProductDetailsRepository {
  final _networkServiceApi = NetworkServiceApi();

  Future<Product> getProductById({required int id}) async {
    try {
      final url = "${ApiUrls.getProductDetails}/$id";
      var response = await _networkServiceApi.getApi(url);
      return Product.fromMap(response);
    } on Failure catch (error) {
      throw Failure(error.message);
    }
  }
}
