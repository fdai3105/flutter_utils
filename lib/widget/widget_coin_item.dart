part of '_widget.dart';

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
