import 'package:equatable/equatable.dart';

import 'coin_bloc.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();
}

class ChangeCurrencyEvent extends CoinEvent {
  final Currency currency;

  const ChangeCurrencyEvent({required this.currency});

  @override
  List<Object> get props => [currency];
}
