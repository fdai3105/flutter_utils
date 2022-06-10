part of '_model.dart';

class New {
  New({
    required this.data,
    required this.status,
  });

  final List<NewDatum> data;
  final NewStatus status;

  factory New.fromRawJson(String str) => New.fromJson(json.decode(str));

  factory New.fromJson(Map<String, dynamic> json) => New(
        data:
            List<NewDatum>.from(json["data"].map((x) => NewDatum.fromJson(x))),
        status: NewStatus.fromJson(json["status"]),
      );
}

class NewDatum {
  NewDatum({
    required this.slug,
    required this.cover,
    required this.assets,
    required this.createdAt,
    required this.meta,
  });

  final String slug;
  final String cover;
  final List<NewAsset> assets;
  final DateTime createdAt;
  final NewMeta meta;

  factory NewDatum.fromRawJson(String str) =>
      NewDatum.fromJson(json.decode(str));

  factory NewDatum.fromJson(Map<String, dynamic> json) => NewDatum(
        slug: json["slug"],
        cover: json["cover"],
        assets: List<NewAsset>.from(
            json["assets"].map((x) => NewAsset.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        meta: NewMeta.fromJson(json["meta"]),
      );
}

class NewAsset {
  NewAsset({
    required this.name,
    required this.coinId,
    required this.type,
  });

  final String name;
  final int coinId;
  final String type;

  factory NewAsset.fromRawJson(String str) =>
      NewAsset.fromJson(json.decode(str));

  factory NewAsset.fromJson(Map<String, dynamic> json) => NewAsset(
        name: json["name"],
        coinId: json["coinId"],
        type: json["type"],
      );
}

class NewMeta {
  NewMeta({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.sourceName,
    required this.maxChar,
    required this.language,
    required this.status,
    required this.type,
    required this.visibility,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.releasedAt,
  });

  final String title;
  final String subtitle;
  final String? content;
  final String sourceName;
  final int maxChar;
  final String language;
  final String status;
  final String type;
  final bool visibility;
  final String sourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime releasedAt;

  factory NewMeta.fromRawJson(String str) => NewMeta.fromJson(json.decode(str));

  factory NewMeta.fromJson(Map<String, dynamic> json) => NewMeta(
        title: json["title"],
        subtitle: json["subtitle"],
        content: json["content"],
        sourceName: json["sourceName"],
        maxChar: json["maxChar"],
        language: json["language"],
        status: json["status"],
        type: json["type"],
        visibility: json["visibility"],
        sourceUrl: json["sourceUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        releasedAt: DateTime.parse(json["releasedAt"]),
      );
}

class NewStatus {
  NewStatus({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
    required this.elapsed,
    required this.creditCount,
  });

  final DateTime timestamp;
  final String errorCode;
  final String errorMessage;
  final String elapsed;
  final int creditCount;

  factory NewStatus.fromRawJson(String str) =>
      NewStatus.fromJson(json.decode(str));

  factory NewStatus.fromJson(Map<String, dynamic> json) => NewStatus(
        timestamp: DateTime.parse(json["timestamp"]),
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        elapsed: json["elapsed"],
        creditCount: json["credit_count"],
      );
}
