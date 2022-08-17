import 'package:bloc/bloc.dart';

import '../../data/provider/provider.dart';
import 'coin_detail_event.dart';
import 'coin_detail_state.dart';

enum DayAgo { day1h, day24h, day7d, day30d, day90d, day1y, all }

extension DayAgoExtension on DayAgo {
  int get from {
    var dur = Duration.zero;
    switch (this) {
      case DayAgo.day1h:
        dur = const Duration(hours: 1);
        break;
      case DayAgo.day24h:
        dur = const Duration(hours: 24);
        break;
      case DayAgo.day7d:
        dur = const Duration(days: 7);
        break;
      case DayAgo.day30d:
        dur = const Duration(days: 30);
        break;
      case DayAgo.day90d:
        dur = const Duration(days: 90);
        break;
      case DayAgo.day1y:
        dur = const Duration(days: 365);
        break;
      case DayAgo.all:
        dur = const Duration(days: 365);
        break;
    }
    return DateTime.now().subtract(dur).millisecondsSinceEpoch;
  }

  double get to => DateTime.now().millisecondsSinceEpoch / 1000;

  int get sub {
    if (this == DayAgo.day1h) return 5;
    if (this == DayAgo.day24h) return 100;
    if (this == DayAgo.day7d) return 500;
    if (this == DayAgo.day30d) return 1000;
    if (this == DayAgo.day90d) return 5000;
    if (this == DayAgo.day1y) return 10000;
    if (this == DayAgo.all) return 20000;
    return 0;
  }
}

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  late final CoinProvider coinProvider;

  CoinDetailBloc() : super(CoinDetailState()) {
    coinProvider = CoinProvider();
    on<ChangeDayEvent>(onChangeDayEvent);
    on<LoadMarketEvent>(onLoadMarketEvent);
  }

  Future onChangeDayEvent(
      ChangeDayEvent event, Emitter<CoinDetailState> emit) async {
    state.charts = null;
    emit(state.copyWith(ago: event.ago, chartLoading: true));
    emit(state.copyWith(
      chartLoading: false,
      charts: await coinProvider.getChart(id: event.id, from: event.ago.from),
    ));
  }

  Future onLoadMarketEvent(
      LoadMarketEvent event, Emitter<CoinDetailState> emit) async {
    state.ticker = null;
    emit(state.copyWith(marketLoading: true, ticker: null));
    emit(state.copyWith(
      marketLoading: false,
      ticker: await coinProvider.getTicker(id: event.id),
    ));
  }
}
