import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/_widget.dart';
import 'coin/coin_tab.dart';
import 'explore/explore_tab.dart';
import 'more/more_tab.dart';
import 'portfolio/portfolio_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController sc = ScrollController();

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 28, 31, 1),
      extendBody: true,
      appBar: WidgetAppbar(
        title: '',
        leading: Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/user-2.svg',
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.white,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: [
            CoinTab(sc: sc),
            ExploreTab(),
            PortfolioTab(),
            MoreTab(),
          ],
        ),
      ),
      bottomNavigationBar: TabNavigation(
        index: _currentIndex,
        onTabPress: (index) {
          if (_currentIndex == index && sc.hasClients) {
            if (sc.offset == 0) return;
            sc.animateTo(
              0,
              duration: const Duration(seconds: 1),
              curve: Curves.bounceIn,
            );
          }
          setState(() => _currentIndex = index);
        },
        tabs: const [
          TabItem(index: 0, icon: 'assets/icons/home.svg'),
          TabItem(index: 1, icon: 'assets/icons/search.svg'),
          TabItem(index: 2, icon: 'assets/icons/wallet.svg'),
          TabItem(index: 3, icon: 'assets/icons/more.svg'),
        ],
      ),
    );
  }
}
