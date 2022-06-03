import 'package:equatable/equatable.dart';

import 'coin_bloc.dart';

class CoinState extends Equatable {
  final Currency currency;

  const CoinState({this.currency = Currency.custom});

  String get currencyString {
    if (currency == Currency.btc) return 'btc';
    if (currency == Currency.custom) return 'usd';
    return 'usd';
  }

  CoinState copyWith({Currency? currency}) {
    return CoinState(
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object> get props => [currency];
}
