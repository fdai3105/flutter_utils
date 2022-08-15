part of '_model.dart';

class Ticker {
  Ticker({
    required this.name,
    required this.tickers,
  });

  final String name;
  final List<TickerElement> tickers;

  factory Ticker.fromRawJson(String str) => Ticker.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        name: json["name"],
        tickers: List<TickerElement>.from(
            json["tickers"].map((x) => TickerElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tickers": List<dynamic>.from(tickers.map((x) => x.toJson())),
      };
}

class TickerElement {
  TickerElement({
    required this.base,
    required this.target,
    required this.market,
    required this.last,
    required this.volume,
    required this.costToMoveUpUsd,
    required this.costToMoveDownUsd,
    required this.convertedLast,
    required this.convertedVolume,
    required this.trustScore,
    required this.bidAskSpreadPercentage,
    required this.timestamp,
    required this.lastTradedAt,
    required this.lastFetchAt,
    required this.isAnomaly,
    required this.isStale,
    required this.tradeUrl,
    required this.tokenInfoUrl,
    required this.coinId,
    required this.targetCoinId,
  });

  final String base;
  final String target;
  final Market market;
  final double last;
  final double volume;
  final double costToMoveUpUsd;
  final double costToMoveDownUsd;
  final Converted convertedLast;
  final Converted convertedVolume;
  final String trustScore;
  final double bidAskSpreadPercentage;
  final DateTime timestamp;
  final DateTime lastTradedAt;
  final DateTime lastFetchAt;
  final bool isAnomaly;
  final bool isStale;
  final String? tradeUrl;
  final dynamic tokenInfoUrl;
  final String coinId;
  final String? targetCoinId;

  factory TickerElement.fromRawJson(String str) =>
      TickerElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TickerElement.fromJson(Map<String, dynamic> json) => TickerElement(
        base: json["base"],
        target: json["target"],
        market: Market.fromJson(json["market"]),
        last: json["last"].toDouble(),
        volume: json["volume"].toDouble(),
        costToMoveUpUsd: json["cost_to_move_up_usd"].toDouble(),
        costToMoveDownUsd: json["cost_to_move_down_usd"].toDouble(),
        convertedLast: Converted.fromJson(json["converted_last"]),
        convertedVolume: Converted.fromJson(json["converted_volume"]),
        trustScore: json["trust_score"],
        bidAskSpreadPercentage: json["bid_ask_spread_percentage"].toDouble(),
        timestamp: DateTime.parse(json["timestamp"]),
        lastTradedAt: DateTime.parse(json["last_traded_at"]),
        lastFetchAt: DateTime.parse(json["last_fetch_at"]),
        isAnomaly: json["is_anomaly"],
        isStale: json["is_stale"],
        tradeUrl: json["trade_url"],
        tokenInfoUrl: json["token_info_url"],
        coinId: json["coin_id"],
        targetCoinId: json["target_coin_id"],
      );

  Map<String, dynamic> toJson() => {
        "base": base,
        "target": target,
        "market": market.toJson(),
        "last": last,
        "volume": volume,
        "cost_to_move_up_usd": costToMoveUpUsd,
        "cost_to_move_down_usd": costToMoveDownUsd,
        "converted_last": convertedLast.toJson(),
        "converted_volume": convertedVolume.toJson(),
        "trust_score": trustScore,
        "bid_ask_spread_percentage": bidAskSpreadPercentage,
        "timestamp": timestamp.toIso8601String(),
        "last_traded_at": lastTradedAt.toIso8601String(),
        "last_fetch_at": lastFetchAt.toIso8601String(),
        "is_anomaly": isAnomaly,
        "is_stale": isStale,
        "trade_url": tradeUrl,
        "token_info_url": tokenInfoUrl,
        "coin_id": coinId,
        "target_coin_id": targetCoinId,
      };
}

class Converted {
  Converted({
    required this.btc,
    required this.eth,
    required this.usd,
  });

  final double btc;
  final double eth;
  final num usd;

  factory Converted.fromRawJson(String str) =>
      Converted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Converted.fromJson(Map<String, dynamic> json) => Converted(
        btc: json["btc"].toDouble(),
        eth: json["eth"].toDouble(),
        usd: json["usd"],
      );

  Map<String, dynamic> toJson() => {
        "btc": btc,
        "eth": eth,
        "usd": usd,
      };
}

class Market {
  Market({
    required this.name,
    required this.identifier,
    required this.hasTradingIncentive,
    required this.logo,
  });

  final String name;
  final String identifier;
  final bool hasTradingIncentive;
  final String logo;

  factory Market.fromRawJson(String str) => Market.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        name: json["name"],
        identifier: json["identifier"],
        hasTradingIncentive: json["has_trading_incentive"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "identifier": identifier,
        "has_trading_incentive": hasTradingIncentive,
        "logo": logo,
      };
}
