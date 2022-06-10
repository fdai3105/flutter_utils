import 'package:equatable/equatable.dart';

import 'coin_detail_bloc.dart';

abstract class CoinDetailEvent extends Equatable {}

class ChangeDayEvent extends CoinDetailEvent {
  final String id;
  final DayAgo ago;

  ChangeDayEvent({required this.id,required this.ago});

  @override
  List<Object?> get props => [id, ago];
}

class LoadMarketEvent extends CoinDetailEvent {
  final String id;

  LoadMarketEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
