
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    required this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (BuildContext context, obj, l) => const SizedBox(),
      );
    }
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        fit: fit,
        width: width,
        height: height,
        // ignore: deprecated_member_use
        color: color,
      );
    } else {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
