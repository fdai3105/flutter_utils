part of '_widget.dart';

class WidgetArrowStatus extends StatelessWidget {
  final num value;

  const WidgetArrowStatus({Key? key, required this.value}) : super(key: key);

  Color get _color => value.isNegative ? Colors.red : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          value.isNegative ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
          color: _color,
        ),
        Text(
          '${value.abs().toStringAsFixed(2)}%',
          style: TextStyle(color: _color,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
