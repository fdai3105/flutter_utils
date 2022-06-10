import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.currentPrice.toString()),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    Text('0,15%'),
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
            borderRadius: BorderRadius.circular(4),
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
        borderRadius: BorderRadius.circular(4),
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
