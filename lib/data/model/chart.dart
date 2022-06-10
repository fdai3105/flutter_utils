part of '_model.dart';

class Chart {
  Chart({
    required this.prices,
    required this.marketCaps,
    required this.totalVolumes,
  });

  final List<List<double>> prices;
  final List<List<double>> marketCaps;
  final List<List<double>> totalVolumes;

  factory Chart.fromRawJson(String str) => Chart.fromJson(json.decode(str));

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        prices: List<List<double>>.from(json["prices"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        marketCaps: List<List<double>>.from(json["market_caps"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        totalVolumes: List<List<double>>.from(json["total_volumes"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );
}
