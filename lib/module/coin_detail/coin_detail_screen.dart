import 'package:flutter/material.dart';

import '../../data/model/_model.dart';
import '../../theme/app_color.dart';
import '../../widget/_widget.dart';
import 'exchange/exchange_tab.dart';
import 'overview/overview_tab.dart';

class CoinDetailScreen extends StatelessWidget {
  final Coin coin;

  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: WidgetAppbar(title: coin.symbol.toUpperCase()),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    OverviewTab(coin: coin),
                    ExchangeTab(coin: coin),
                    Text('Portfolio'),
                    Text('Historical Data'),
                  ],
                ),
              ),
              TabBar(
                isScrollable: true,
                labelColor: AppColors.light,
                unselectedLabelColor: AppColors.light2,
                indicator: const BoxDecoration(),
                physics: const BouncingScrollPhysics(),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Markets'),
                  Tab(text: 'Portfolio'),
                  Tab(text: 'Historical Data'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
