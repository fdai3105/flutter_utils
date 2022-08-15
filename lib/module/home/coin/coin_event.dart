import 'package:equatable/equatable.dart';

import 'coin_bloc.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();
}

class LoadCoinsEvent extends CoinEvent {
  const LoadCoinsEvent();

  @override
  List<Object?> get props => [];
}

class ChangeCurrencyEvent extends CoinEvent {
  final Currency currency;

  const ChangeCurrencyEvent({required this.currency});

  @override
  List<Object> get props => [currency];
}

class ChangeSortEvent extends CoinEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
