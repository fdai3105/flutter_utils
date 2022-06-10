part of '_widget.dart';

class WidgetImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final bool isSvg;
  final BoxFit fit;
  final double border;

  const WidgetImage({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.isSvg = false,
    this.fit = BoxFit.cover,
    this.border = 0,
  }) : super(key: key);

  Widget buildPlaceHolder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const CupertinoActivityIndicator(
        color: AppColors.primary,
        radius: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.network(url, placeholderBuilder: buildPlaceHolder);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, s) => buildPlaceHolder(context),
      ),
    );
  }
}
