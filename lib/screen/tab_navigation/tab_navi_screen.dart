import 'package:flutter/material.dart';

import '../../data/model/model.dart';
import '../../data/provider/coin_provider.dart';
import '../../widget/widget.dart';

class TabNavigationScreen extends StatefulWidget {
  const TabNavigationScreen({Key? key}) : super(key: key);

  @override
  State<TabNavigationScreen> createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 28, 31, 1),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            WidgetList<Coin>(
              load: () => CoinProvider().getCoins(1),
              loadMore: (page) => CoinProvider().getCoins(page),
              buildItem: <T>(item, index) {
                final i = item as Coin;
                return Container(
                  child: Row(
                    children: [
                      Image.network(i.image, height: 20, width: 20),
                      Column(
                        children: [
                          Text(i.name),
                          Row(
                            children: [
                              Container(child: Text('${index + 1}')),
                              Text(i.symbol),
                              Text(
                                i.priceChangePercentage24H.toStringAsFixed(2),
                              )
                            ],
                          )
                        ],
                      ),
                      Flexible(
                        child: Image.network(i.sparkline, height: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Text('Page 2'),
            const Text('Page 3'),
            const Text('Page 4'),
          ],
        ),
      ),
      bottomNavigationBar: TabNavigation(
        index: _currentIndex,
        onTabPress: (index) => setState(() => _currentIndex = index),
        tabs: const [
          TabItem(index: 0, icon: Icons.home_outlined),
          TabItem(index: 1, icon: Icons.home_outlined),
          TabItem(index: 2, icon: Icons.home_outlined),
          TabItem(index: 3, icon: Icons.home_outlined),
        ],
      ),
    );
  }
}
