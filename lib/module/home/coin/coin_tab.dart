import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/_model.dart';
import '../../../data/provider/provider.dart';
import '../../../theme/app_color.dart';
import '../../../utils/navigation.dart';
import '../../../widget/_widget.dart';
import '../../coin_detail/coin_detail_screen.dart';
import 'coin_bloc.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinTab extends StatelessWidget {
  const CoinTab({Key? key}) : super(key: key);

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
                  buildFilterButton(
                    text: state.currencyString.toUpperCase(),
                    onTap: () {
                      final provider = context.read<CoinBloc>();
                      if (state.currency == Currency.btc) {
                        provider.add(const ChangeCurrencyEvent(
                          currency: Currency.custom,
                        ));
                      } else if (state.currency == Currency.custom) {
                        provider.add(const ChangeCurrencyEvent(
                          currency: Currency.btc,
                        ));
                      }
                    },
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
            return Expanded(
              child: WidgetList<Coin>(
                load: () => CoinProvider().getCoins(
                  1,
                  currency: state.currencyString,
                ),
                loadMore: (page) => CoinProvider().getCoins(
                  page,
                  currency: state.currencyString,
                ),
                buildItem: (item, index) => ItemCoin(
                  item: item as Coin,
                  index: index,
                  onPress: () => Navigation.push(
                    context,
                    CoinDetailScreen(coin: item),
                  ),
                ),
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
                  item.currentPrice.toString(),
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
