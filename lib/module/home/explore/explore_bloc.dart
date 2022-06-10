import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/_model.dart';
import '../../../data/provider/other_provider.dart';
import '../../../data/provider/provider.dart';

part 'explore_event.dart';

part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  late final CoinProvider coinProvider;
  late final OtherProvider otherProvider;

  ExploreBloc() : super(const ExploreState()) {
    coinProvider = CoinProvider();
    otherProvider = OtherProvider();
    on<ExploreEvent>((event, emit) {});
    on<LoadCoinTrendingEvent>(onLoadTrendingEvent);
    on<LoadNewsEvent>(onLoadNewEvent);
  }

  Future onLoadTrendingEvent(LoadCoinTrendingEvent event, Emitter emit) async {
    emit(state.copyWith(trendLoading: true, trending: null));
    emit(state.copyWith(
      trendLoading: false,
      trending: await coinProvider.getTrending(),
    ));
  }

  Future onLoadNewEvent(LoadNewsEvent event, Emitter emit) async {
    emit(state.copyWith(newsLoading: true, news: null));
    emit(state.copyWith(
      newsLoading: false,
      news: await otherProvider.getNews(),
    ));
  }
}
