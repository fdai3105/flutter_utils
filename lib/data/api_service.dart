import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class ApiService extends DioForNative {
  ApiService([BaseOptions? base]) : super(base = BaseOptions()) {
    base.baseUrl = 'https://api.coingecko.com/api/v3/';
  }
}

extension Demo on Response {
  bool get ok => data != null && statusCode == 200;
}
