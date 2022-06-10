part of '_widget.dart';

class WidgetTickerItem extends StatelessWidget {
  const WidgetTickerItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final TickerElement item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item.base}/${item.target}', maxLines: 1),
                const SizedBox(height: 4),
                Text(
                  'Spread: ${item.bidAskSpreadPercentage.toStringAsFixed(2)}',
                  style: const TextStyle(color: AppColors.light6, fontSize: 10),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WidgetImage(
                      url: item.market.logo,
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(StringUtils.sub(12, item.market.name)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Trust:',
                      style: TextStyle(fontSize: 10, color: AppColors.light6),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(StringUtils.formatCurrency(item.convertedVolume.usd)),
                const SizedBox(height: 4),
                Text(
                  'Vol ${item.volume.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 10, color: AppColors.light6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
