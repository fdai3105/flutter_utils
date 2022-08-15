import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../data/model/_model.dart';
import '../../../theme/app_color.dart';
import '../../../utils/navigation.dart';
import '../../../widget/_widget.dart';
import '../../coin_detail/coin_detail_screen.dart';
import 'coin_bloc.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinTab extends StatefulWidget {
  final ScrollController sc;

  const CoinTab({Key? key, required this.sc}) : super(key: key);

  @override
  State<CoinTab> createState() => _CoinTabState();
}

class _CoinTabState extends State<CoinTab> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<CoinBloc>();
    widget.sc.addListener(() {
      if (!widget.sc.hasClients || bloc.state.loadingMore) return;
      if (widget.sc.position.extentAfter < 200) bloc.add(const LoadCoinsEvent());
    });
  }

  Widget buildFilterButton({
    required String text,
    bool showArrow = false,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.dark4,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(text),
            if (showArrow) ...[
              const SizedBox(width: 2),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Colors.white,
              )
            ]
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CoinBloc>();
    return Column(
      children: [
        BlocBuilder<CoinBloc, CoinState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state.currency == Currency.btc) {
                        bloc.add(const ChangeCurrencyEvent(
                          currency: Currency.custom,
                        ));
                      } else if (state.currency == Currency.custom) {
                        bloc.add(const ChangeCurrencyEvent(
                          currency: Currency.btc,
                        ));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.dark4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'USD',
                            style: TextStyle(
                              color: state.currency == Currency.custom
                                  ? null
                                  : AppColors.secondary,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text('/'),
                          ),
                          Text(
                            'BTC',
                            style: TextStyle(
                              color: state.currency == Currency.btc
                                  ? null
                                  : AppColors.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  buildFilterButton(text: 'My Watchlist', onTap: () {}),
                  const SizedBox(width: 8),
                  buildFilterButton(text: 'All Coins', onTap: () {}),
                  const SizedBox(width: 8),
                  buildFilterButton(
                    text: 'Sort by Rank',
                    showArrow: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        enableDrag: true,
                        builder: (context) {
                          return const WidgetBottomSheet(
                            title: 'Sort by Rank',
                            children: [
                              ListTile(title: Text('Rank')),
                              ListTile(title: Text('Change')),
                              ListTile(title: Text('Market Cap')),
                              ListTile(title: Text('Volume (24H)')),
                              ListTile(title: Text('Price')),
                              ListTile(title: Text('Name')),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        BlocBuilder<CoinBloc, CoinState>(
          builder: (context, state) {
            if (state.coins == null || state.coins!.isEmpty) {
              return const Center(child: Text('Server Error'));
            }
            return Expanded(
              child: ListView.builder(
                controller: widget.sc,
                physics: const BouncingScrollPhysics(),
                itemCount: state.coins!.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.coins!.length) {
                    if (state.loadingMore) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.light2,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }
                  final item = state.coins![index];
                  return ItemCoin(
                    item: item,
                    index: index,
                    onPress: () => Navigation.push(
                      context,
                      CoinDetailScreen(coin: item),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemCoin extends StatelessWidget {
  const ItemCoin({
    Key? key,
    required this.item,
    required this.index,
    required this.onPress,
  }) : super(key: key);

  final Coin item;
  final int index;
  final Function() onPress;

  List<Widget> buildPercent() {
    var icon = Icons.horizontal_rule_rounded;
    var color = Colors.grey;
    if (item.priceChangePercentage24H < 0) {
      icon = Icons.keyboard_arrow_down_rounded;
      color = Colors.red;
    } else if (item.priceChangePercentage24H > 0) {
      icon = Icons.keyboard_arrow_up_rounded;
      color = Colors.green;
    }
    return [
      Icon(icon, color: color, size: 16),
      Text(
        item.priceChangePercentage24H.abs().toStringAsFixed(2),
        style: TextStyle(fontSize: 12, color: color),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            WidgetImage(
              url: item.image,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.dark4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.symbol.toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 6),
                    ...buildPercent(),
                  ],
                )
              ],
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.network(
                  item.sparkline,
                  height: 36,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  // item.currentPrice.toString(),
                  NumberFormat.simpleCurrency(
                    name: '',
                  ).format(item.currentPrice),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  'MCap ${(item.marketCap / 1000000000).toStringAsFixed(2)} Bn',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
