import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/_model.dart';
import '../../../widget/_widget.dart';
import '../bloc/coin_detail_bloc.dart';
import '../bloc/coin_detail_event.dart';
import '../bloc/coin_detail_state.dart';

class ExchangeTab extends StatefulWidget {
  final Coin coin;

  const ExchangeTab({Key? key, required this.coin}) : super(key: key);

  @override
  State<ExchangeTab> createState() => _ExchangeTabState();
}

class _ExchangeTabState extends State<ExchangeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CoinDetailBloc, CoinDetailState>(
      bloc: CoinDetailBloc()..add(LoadMarketEvent(id: widget.coin.id)),
      builder: (context, state) {
        if (state.marketLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state.ticker == null || state.ticker?.tickers == null) {
          return const Center(child: Text('Server error'));
        }
        return ListView.builder(
          itemCount: state.ticker!.tickers.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, i) => WidgetTickerItem(
            item: state.ticker!.tickers[i],
            index: i,
          ),
        );
      },
    );
  }
}
