import 'package:equatable/equatable.dart';

import 'coin_bloc.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();
}

class LoadCoinsEvent extends CoinEvent {
  final bool showLoading;

  const LoadCoinsEvent({this.showLoading = false});

  @override
  List<Object?> get props => [showLoading];
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
