import 'package:equatable/equatable.dart';

import '../../../data/model/_model.dart';
import 'coin_detail_bloc.dart';

class CoinDetailState extends Equatable {
  final DayAgo ago;
  final bool chartLoading;
  Chart? charts;
  final bool marketLoading;
  Ticker? ticker;

  CoinDetailState({
    this.ago = DayAgo.day1h,
    this.chartLoading = true,
    this.charts,
    this.marketLoading = true,
    this.ticker,
  });

  CoinDetailState copyWith({
    DayAgo? ago,
    bool? chartLoading,
    Chart? charts,
    bool? marketLoading,
    Ticker? ticker,
  }) {
    return CoinDetailState(
      ago: ago ?? this.ago,
      chartLoading: chartLoading ?? this.chartLoading,
      charts: charts ?? this.charts,
      marketLoading: marketLoading ?? this.marketLoading,
      ticker: ticker ?? this.ticker,
    );
  }

  @override
  List<Object?> get props => [ago, chartLoading, charts, marketLoading, ticker];
}
