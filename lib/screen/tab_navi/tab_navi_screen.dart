import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/widget/widget.dart';

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
          children: const [
            Text('Page 1'),
            Text('Page 2'),
            Text('Page 3'),
            Text('Page 4'),
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
