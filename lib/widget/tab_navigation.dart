part of 'widget.dart';

class TabItem {
  const TabItem({required this.index, required this.icon});

  final int index;
  final IconData icon;
}

class TabNavigation extends StatelessWidget {
  final int index;
  final List<TabItem> tabs;
  final Function(int index) onTabPress;

  const TabNavigation({
    Key? key,
    required this.index,
    required this.tabs,
    required this.onTabPress,
  }) : super(key: key);

  Widget tabItem(TabItem item) {
    final selected = index == item.index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: IconButton(
            onPressed: () => onTabPress(item.index),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.transparent,
            icon: Icon(
              item.icon,
              color: selected
                  ? const Color.fromRGBO(69, 129, 107, 1)
                  : const Color.fromRGBO(72, 78, 82, 1),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: selected ? 1 : 0,
          duration: const Duration(milliseconds: 240),
          child: AnimatedContainer(
            height: 3,
            duration: const Duration(milliseconds: 240),
            width: selected ? 24 : 0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(69, 129, 107, 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(69, 129, 107, 1),
                  blurRadius: 40,
                  spreadRadius: 12,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(41, 47, 51, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs.map<Widget>(tabItem).toList(),
        ),
      ),
    );
  }
}
