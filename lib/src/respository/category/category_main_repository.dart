import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/network/network_service_api.dart';
import 'package:commzy/src/models/category/category_model.dart';
import 'package:commzy/src/resources/urls/api_urls.dart';

class CategoryMainRepository {
  final _networkServiceApi = NetworkServiceApi();

  Future<List<CategoryModel>> getHomePageCategories() async {
    try {
      var response = await _networkServiceApi.getApi(ApiUrls.getCategories);

      return (response as List)
          .map((c) => CategoryModel.fromMap(c as Map<String, dynamic>))
          .toList();
    } on Failure catch (error) {
      throw Failure(error.message);
    }
  }
}
