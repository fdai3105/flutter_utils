part of 'provider.dart';

class CoinProvider extends ApiService {
  static const getCoinsURL = 'https://api.coingecko.com/api/v3/coins/markets';

  Future<List<Coin>?> getCoins(
    int page, {
    int size = 20,
    String currency = 'usd',
  }) async {
    try {
      final resp = await get(
        getCoinsURL,
        queryParameters: {
          'vs_currency': currency,
          'per_page': size,
          'page': page
        },
      );
      if (resp.statusCode == 200 && resp.data != null) {
        return List.from(resp.data.map((e) => Coin.fromJson(e)));
      }
    } on DioError catch (e, s) {
      print('getCoins: ${e.response?.data}');
      print(s);
    }
  }
}
