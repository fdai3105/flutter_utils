import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/model/_model.dart';
import '../../../theme/app_color.dart';
import '../../../utils/string_utils.dart';
import '../bloc/coin_detail_bloc.dart';
import '../bloc/coin_detail_event.dart';
import '../bloc/coin_detail_state.dart';

class OverviewTab extends StatelessWidget {
  final Coin coin;

  const OverviewTab({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CoinDetailBloc>();
    bloc.add(ChangeDayEvent(id: coin.id, ago: DayAgo.day1h));
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(coin.name),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${coin.currentPrice}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2).add(EdgeInsets.only(right: 2)),
                decoration: BoxDecoration(
                  color: coin.priceChangePercentage24H.isNegative
                      ? Colors.red
                      : Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      coin.priceChangePercentage24H.isNegative
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      '${coin.priceChangePercentage24H.toStringAsFixed(2)}% ',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<CoinDetailBloc, CoinDetailState>(
            builder: (context, state) {
              return WidgetSelectDay(
                selected: state.ago,
                onTap: (d) => context
                    .read<CoinDetailBloc>()
                    .add(ChangeDayEvent(id: coin.id, ago: d)),
              );
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: BlocBuilder<CoinDetailBloc, CoinDetailState>(
              builder: (context, state) {
                if (state.chartLoading) {
                  return const CupertinoActivityIndicator(
                      color: AppColors.light);
                }
                if (state.charts == null) return const Text('Server error');
                return LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, meta) {
                              final time = DateTime.fromMillisecondsSinceEpoch(
                                  v.round());
                              return Text(
                                '${time.hour}:${time.minute}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.light2,
                                ),
                              );
                            }),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 42,
                          getTitlesWidget: (v, meta) {
                            if (v.round() % state.ago.sub == 0) {
                              return Text(
                                StringUtils.formatCurrency(v),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.light2,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      checkToShowHorizontalLine: (v) => v % state.ago.sub == 0,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        dotData: FlDotData(show: false),
                        isCurved: true,
                        color: AppColors.secondary,
                        belowBarData: BarAreaData(
                          show: true,
                          cutOffY: coin.currentPrice,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.secondary,
                              Colors.transparent,
                            ].map((e) => e.withOpacity(0.3)).toList(),
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        spots: state.charts!.prices
                            .map((e) => FlSpot(e.first, e.last))
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.dark4,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                buildTableItem('Market Cap Rank', '#${coin.marketCapRank}'),
                buildTableItem(
                  'Market Cap',
                  NumberFormat.simpleCurrency(decimalDigits: 0)
                      .format(coin.marketCap),
                ),
                buildTableItem(
                  'Fully Diluted Valuation',
                  NumberFormat.simpleCurrency(decimalDigits: 0)
                      .format(coin.fullyDilutedValuation),
                ),
                buildTableItem(
                  'Trading Volume',
                  NumberFormat.simpleCurrency(decimalDigits: 0)
                      .format(coin.totalVolume),
                ),
                buildTableItem(
                  'High 24h',
                  NumberFormat.simpleCurrency().format(coin.high24H),
                ),
                buildTableItem(
                  'Low 24h',
                  NumberFormat.simpleCurrency().format(coin.low24H),
                ),
                buildTableItem(
                  'Circulating Supply',
                  NumberFormat.compactLong().format(coin.circulatingSupply),
                ),
                buildTableItem(
                  'Total Supply',
                  NumberFormat.compactLong().format(coin.totalSupply),
                ),
                buildTableItem(
                  'Max Supply',
                  NumberFormat.compactLong().format(coin.maxSupply),
                ),
                buildTableItem(
                  'Last Updated',
                  timeago.format(coin.lastUpdated),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTableItem(String name, value) {
    if (value == null) return const SizedBox();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.light2, width: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: AppColors.light4)),
          Text(value.toString(), style: TextStyle()),
        ],
      ),
    );
  }
}

class WidgetSelectDay extends StatelessWidget {
  final DayAgo selected;
  final Function(DayAgo day) onTap;

  const WidgetSelectDay({
    Key? key,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  Widget buildItem(DayAgo day, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(day),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected == day ? Colors.black87 : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title, style: const TextStyle(fontSize: 10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.dark4,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          buildItem(DayAgo.day1h, '1h'),
          buildItem(DayAgo.day24h, '24h'),
          buildItem(DayAgo.day7d, '7d'),
          buildItem(DayAgo.day30d, '30d'),
          buildItem(DayAgo.day90d, '90d'),
          buildItem(DayAgo.day1y, '1y'),
          buildItem(DayAgo.all, 'All'),
        ],
      ),
    );
  }
}
