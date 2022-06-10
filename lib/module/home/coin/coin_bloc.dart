import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/provider/provider.dart';
import 'coin_event.dart';
import 'coin_state.dart';

enum Currency { custom, btc }

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  late final CoinProvider coinProvider;

  CoinBloc() : super(const CoinState()) {
    coinProvider = CoinProvider();
    on<ChangeCurrencyEvent>(onCurrencyChange);
  }

  void onCurrencyChange(ChangeCurrencyEvent event, Emitter<CoinState> emit) {
    emit(state.copyWith(currency: event.currency));
  }
}
