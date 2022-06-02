part of 'model.dart';

class Passenger {
  Passenger({
    required this.totalPassengers,
    required this.totalPages,
    required this.data,
  });

  final int totalPassengers;
  final int totalPages;
  final List<PassengerDatum> data;

  factory Passenger.fromRawJson(String str) =>
      Passenger.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        totalPassengers: json["totalPassengers"],
        totalPages: json["totalPages"],
        data: List<PassengerDatum>.from(
            json["data"].map(PassengerDatum.fromJson)),
      );

  Map<String, dynamic> toJson() => {
        "totalPassengers": totalPassengers,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PassengerDatum {
  PassengerDatum({
    required this.id,
    required this.name,
    required this.trips,
    required this.airline,
    required this.v,
  });

  final String id;
  final String name;
  final int? trips;
  final List<Airline> airline;
  final int v;

  factory PassengerDatum.fromRawJson(String str) =>
      PassengerDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PassengerDatum.fromJson(Map<String, dynamic> json) => PassengerDatum(
        id: json["_id"],
        name: json["name"],
        trips: json["trips"],
        airline: List<Airline>.from(json["airline"].map(Airline.fromJson)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "trips": trips,
        "airline": List<dynamic>.from(airline.map((x) => x.toJson())),
        "__v": v,
      };
}

class Airline {
  Airline({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.slogan,
    required this.headQuaters,
    required this.website,
    required this.established,
  });

  final int id;
  final String name;
  final String? country;
  final String? logo;
  final String? slogan;
  final String? headQuaters;
  final String? website;
  final String? established;

  factory Airline.fromRawJson(String str) => Airline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        slogan: json["slogan"],
        headQuaters: json["head_quaters"],
        website: json["website"],
        established: json["established"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "slogan": slogan,
        "head_quaters": headQuaters,
        "website": website,
        "established": established,
      };
}
