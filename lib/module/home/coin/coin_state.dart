import 'package:equatable/equatable.dart';

import '../../../data/model/_model.dart';
import 'coin_bloc.dart';

class CoinState extends Equatable {
  final List<Coin>? coins;
  final bool loading;
  final bool loadingMore;
  final int page;
  final Currency currency;

  const CoinState({
    this.coins,
    this.loading = false,
    this.page = 0,
    this.loadingMore = false,
    this.currency = Currency.custom,
  });

  String get currencyStr {
    if (currency == Currency.btc) return 'btc';
    if (currency == Currency.custom) return 'usd';
    return 'usd';
  }

  CoinState copyWith({
    List<Coin>? coins,
    bool? loading,
    int? page,
    bool? loadingMore,
    Currency? currency,
  }) {
    return CoinState(
      coins: coins ?? this.coins,
      loading: loading ?? this.loading,
      page: page ?? this.page,
      loadingMore: loadingMore ?? this.loadingMore,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<dynamic> get props => [coins, loading, page, loadingMore, currency];
}
