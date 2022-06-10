import 'package:dio/dio.dart';

import '../api_service.dart';
import '../model/_model.dart';

class OtherProvider extends ApiService {
  OtherProvider() {
    options.baseUrl = '';
  }

  static const getNewsURL = 'https://api.coinmarketcap.com/content/v3/news';

  Future<New?> getNews({int page = 1, int size = 5}) async {
    try {
      final resp = await get(getNewsURL, queryParameters: {
        'page': page,
        'size': size,
      });
      if (resp.ok) return New.fromJson(resp.data);
    } on DioError catch (e, s) {
      print('getNews: ${e.response?.data ?? e.message}');
      print(s);
    }
  }
}
