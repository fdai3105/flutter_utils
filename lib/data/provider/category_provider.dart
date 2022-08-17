import 'package:dio/dio.dart';

import '../api_service.dart';
import '../model/_model.dart';

class CategoryProvider extends ApiService {
  static const getCategoriesURL = 'coins/categories';

  Future<List<Category>?> getCategories() async {
    try {
      final resp = await get(
        getCategoriesURL,
        queryParameters: {'order': 'market_cap_asc'},
      );
      return List.from(resp.data).map((e) => Category.fromJson(e)).toList();
    } on DioError catch (e) {
      print('getCategories: ${e.message}');
    }
  }
}
