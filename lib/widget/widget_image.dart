import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_color.dart';

class WidgetImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final bool isSvg;
  final BoxFit fit;

  const WidgetImage({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.isSvg = false,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  Widget buildPlaceHolder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.tertiary, borderRadius: BorderRadius.circular(10)),
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
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      placeholder: (context, s) => buildPlaceHolder(context),
    );
  }
}
