part of '_model.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.marketCap,
    required this.marketCapChange24H,
    required this.content,
    required this.top3Coins,
    required this.volume24H,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final double marketCap;
  final double marketCapChange24H;
  final String? content;
  final List<String> top3Coins;
  final double volume24H;
  final DateTime updatedAt;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        marketCap: json["market_cap"].toDouble(),
        marketCapChange24H: json["market_cap_change_24h"].toDouble(),
        content: json["content"],
        top3Coins: List<String>.from(json["top_3_coins"].map((x) => x)),
        volume24H: json["volume_24h"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
