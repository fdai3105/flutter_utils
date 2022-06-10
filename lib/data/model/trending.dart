part of '_model.dart';

class CoinTrending {
  CoinTrending({
    required this.coins,
    required this.exchanges,
  });

  final List<CoinTrendingItem> coins;
  final List<dynamic> exchanges;

  factory CoinTrending.fromRawJson(String str) =>
      CoinTrending.fromJson(json.decode(str));

  factory CoinTrending.fromJson(Map<String, dynamic> json) => CoinTrending(
        coins: List<CoinTrendingItem>.from(
            json["coins"].map((x) => CoinTrendingItem.fromJson(x))),
        exchanges: List<dynamic>.from(json["exchanges"].map((x) => x)),
      );
}

class CoinTrendingItem {
  CoinTrendingItem({required this.item});

  final CoinTrendingData item;

  factory CoinTrendingItem.fromRawJson(String str) =>
      CoinTrendingItem.fromJson(json.decode(str));

  factory CoinTrendingItem.fromJson(Map<String, dynamic> json) =>
      CoinTrendingItem(item: CoinTrendingData.fromJson(json["item"]));
}

class CoinTrendingData {
  CoinTrendingData({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.small,
    required this.large,
    required this.slug,
    required this.priceBtc,
    required this.score,
  });

  final String id;
  final int coinId;
  final String name;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String small;
  final String large;
  final String slug;
  final double priceBtc;
  final int score;

  factory CoinTrendingData.fromRawJson(String str) =>
      CoinTrendingData.fromJson(json.decode(str));

  factory CoinTrendingData.fromJson(Map<String, dynamic> json) =>
      CoinTrendingData(
        id: json["id"],
        coinId: json["coin_id"],
        name: json["name"],
        symbol: json["symbol"],
        marketCapRank: json["market_cap_rank"],
        thumb: json["thumb"],
        small: json["small"],
        large: json["large"],
        slug: json["slug"],
        priceBtc: json["price_btc"].toDouble(),
        score: json["score"],
      );
}
