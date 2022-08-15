import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/provider/provider.dart';
import 'coin_event.dart';
import 'coin_state.dart';

enum Currency { custom, btc }

enum Sort { rank, change, cap, volume, price, name }

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  late final CoinProvider coinProvider;

  CoinBloc() : super(const CoinState()) {
    coinProvider = CoinProvider();
    on<ChangeCurrencyEvent>(onCurrencyChange);
    on<LoadCoinsEvent>(onLoadCoins);

    add(const LoadCoinsEvent());
  }

  Future onCurrencyChange(
      ChangeCurrencyEvent event, Emitter<CoinState> emit) async {
    try {
      emit(state.copyWith(currency: event.currency));
      emit(state.copyWith(
        page: 1,
        coins: await coinProvider.getCoins(1, currency: state.currencyStr),
      ));
    } catch (e) {
      emit(state.copyWith(currency: state.currency));
    }
  }

  Future onChangeSort() async {
    try {} catch (e) {}
  }

  Future onLoadCoins(LoadCoinsEvent event, Emitter<CoinState> emit) async {
    try {
      emit(state.copyWith(page: state.page + 1, loadingMore: true));
      final resp = await coinProvider.getCoins(
        state.page,
        currency: state.currencyStr,
      );
      emit(state.copyWith(coins: [...?state.coins, ...?resp]));
    } catch (e) {
      emit(state.copyWith(page: state.page - 1));
    } finally {
      emit(state.copyWith(loadingMore: false));
    }
  }
}
