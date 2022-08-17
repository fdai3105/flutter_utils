import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_color.dart';
import '../../../utils/navigation.dart';
import '../../../widget/_widget.dart';
import '../../coin_detail/coin_detail_screen.dart';
import 'category/category_tab.dart';
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
      if (widget.sc.position.extentAfter < 200) {
        bloc.add(const LoadCoinsEvent());
      }
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
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelColor: AppColors.light,
            unselectedLabelColor: AppColors.light2,
            indicator: const BoxDecoration(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: const [Tab(text: 'Coins'), Tab(text: 'Categories')],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    BlocBuilder<CoinBloc, CoinState>(
                      builder: (context, state) {
                        final bloc = context.read<CoinBloc>();
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
                                  } else if (state.currency ==
                                      Currency.custom) {
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
                                          color:
                                              state.currency == Currency.custom
                                                  ? AppColors.secondary
                                                  : null,
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Text('/'),
                                      ),
                                      Text(
                                        'BTC',
                                        style: TextStyle(
                                          color: state.currency == Currency.btc
                                              ? AppColors.secondary
                                              : null,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              buildFilterButton(
                                  text: 'My Watchlist', onTap: () {}),
                              const SizedBox(width: 8),
                              buildFilterButton(
                                  text: 'All Coins', onTap: () {}),
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
                    Expanded(
                      child: BlocBuilder<CoinBloc, CoinState>(
                        builder: (context, state) {
                          if (state.loading) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          }
                          if (state.coins?.isEmpty ?? true) {
                            return const Center(child: Text('Server Error'));
                          }
                          return ListView.builder(
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const CategoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
