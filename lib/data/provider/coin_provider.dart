import '../api_serivce.dart';
import '../model/model.dart';

class CoinProvider extends ApiService {
  static const getCoinsURL = 'https://api.coingecko.com/api/v3/coins/markets';

  Future<List<Coin>?> getCoins(int page, {int size = 20}) async {
    try {
      final resp = await get(
        getCoinsURL,
        queryParameters: {'vs_currency': 'vnd', 'per_page': size, 'page': page},
      );
      if (resp.statusCode == 200 && resp.data != null) {
        return List.from(resp.data.map(Coin.fromJson));
      }
    } catch (e) {
      print(e);
    }
  }
}
