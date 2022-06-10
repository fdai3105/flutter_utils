part of 'provider.dart';

class CoinProvider extends ApiService {
  static const getCoinsURL = 'coins/markets';
  static const getCoinChartUrl = 'coins/:id/market_chart/range';
  static const getTickerUrl = 'coins/:id/tickers';
  static const getTrendingURL = 'search/trending';

  Future<List<Coin>?> getCoins(int page,
      {int size = 20, String? currency}) async {
    try {
      final resp = await get(
        getCoinsURL,
        queryParameters: {
          'vs_currency': currency ?? 'usd',
          'per_page': size,
          'page': page
        },
      );
      if (resp.ok) return List.from(resp.data.map((e) => Coin.fromJson(e)));
    } on DioError catch (e, s) {
      print('getCoins: ${e.response?.data}');
      print(s);
    }
  }

  Future<Chart?> getChart({required String id, required int from}) async {
    try {
      print((from / 1000).round());
      print(DateTime.now().millisecondsSinceEpoch / 1000);
      final resp = await get(
        getCoinChartUrl.replaceAll(':id', id),
        queryParameters: {
          'vs_currency': 'usd',
          'from': (from / 1000).round(),
          'to': (DateTime.now().millisecondsSinceEpoch / 1000).round(),
        },
      );
      if (resp.ok) return Chart.fromJson(resp.data);
    } on DioError catch (e, s) {
      print('getChart: ${e.message}');
      print(s);
    }
  }

  Future<Ticker?> getTicker({required String id}) async {
    try {
      final resp = await get(
        getTickerUrl.replaceAll(':id', id),
        queryParameters: {'include_exchange_logo': true, 'depth': true},
      );
      if (resp.ok) return Ticker.fromJson(resp.data);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<CoinTrending?> getTrending() async {
    try {
      final resp = await get(getTrendingURL);
      if (resp.ok) return CoinTrending.fromJson(resp.data);
    } on DioError catch (e, s) {
      print('getTrending: ${e.response?.data ?? e.message}');
      print(s);
    }
  }
}
