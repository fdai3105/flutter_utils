part of '_widget.dart';

class WidgetField extends StatelessWidget {
  final String? label;
  final Function(String? v) onChanged;

  const WidgetField({Key? key, this.label, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.dark2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.secondary,
        decoration: InputDecoration(
          hintText: ' $label',
          hintStyle: const TextStyle(color: AppColors.light2),
          isDense: true,
          border: InputBorder.none,
          fillColor: AppColors.dark2,
        ),
      ),
    );
  }
}
