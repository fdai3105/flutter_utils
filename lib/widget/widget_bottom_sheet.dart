part of '_widget.dart';

class WidgetBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const WidgetBottomSheet({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 6,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.dark4,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(title),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: children),
            ),
          ),
        ],
      ),
    );
  }
}
