part of '_model.dart';

class Coin {
  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.sparkline,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final String sparkline;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double? fullyDilutedValuation;
  final num totalVolume;
  final double high24H;
  final double low24H;
  final double priceChange24H;
  final double priceChangePercentage24H;
  final double marketCapChange24H;
  final double marketCapChangePercentage24H;
  final double circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final double athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final Roi? roi;
  final DateTime lastUpdated;

  factory Coin.fromRawJson(String str) => Coin.fromJson(json.decode(str));

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        sparkline:
            'https://coingecko.com/coins/${json["image"]?.split('/')[5]}/sparkline',
        currentPrice: json["current_price"].toDouble(),
        marketCap: json["market_cap"].toDouble(),
        marketCapRank: json["market_cap_rank"],
        fullyDilutedValuation: json["fully_diluted_valuation"]?.toDouble(),
        totalVolume: json["total_volume"],
        high24H: json["high_24h"].toDouble(),
        low24H: json["low_24h"].toDouble(),
        priceChange24H: json["price_change_24h"].toDouble(),
        priceChangePercentage24H:
            json["price_change_percentage_24h"].toDouble(),
        marketCapChange24H: json["market_cap_change_24h"].toDouble(),
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"].toDouble(),
        circulatingSupply: json["circulating_supply"].toDouble(),
        totalSupply: json["total_supply"]?.toDouble(),
        maxSupply: json["max_supply"]?.toDouble(),
        ath: json["ath"].toDouble(),
        athChangePercentage: json["ath_change_percentage"].toDouble(),
        athDate: DateTime.parse(json["ath_date"]),
        atl: json["atl"].toDouble(),
        atlChangePercentage: json["atl_change_percentage"].toDouble(),
        atlDate: DateTime.parse(json["atl_date"]),
        roi: json["roi"] == null ? null : Roi.fromJson(json["roi"]),
        lastUpdated: DateTime.parse(json["last_updated"]),
      );
}

class Roi {
  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  final double times;
  final String currency;
  final double percentage;

  factory Roi.fromRawJson(String str) => Roi.fromJson(json.decode(str));

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: json["times"].toDouble(),
        currency: json["currency"],
        percentage: json["percentage"].toDouble(),
      );
}
