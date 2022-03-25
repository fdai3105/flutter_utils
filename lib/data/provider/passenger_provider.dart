import 'package:dio/native_imp.dart';
import 'package:flutter_bloc_boilerplate/data/model/model.dart';

class PassengerProvider extends DioForNative {
  Future<List<PassengerDatum>?> loadPassenger(int page, {int size = 20}) async {
    try {
      final resp = await get(
        'https://api.instantwebtools.net/v1/passenger',
        queryParameters: {'page': page, 'size': size},
      );
      if (resp.statusCode == 200 && resp.data != null) {
        return Passenger.fromJson(resp.data).data;
      }
    } catch (e,s) {
      print(e.toString());
      print(s.toString());
    }
  }
}
