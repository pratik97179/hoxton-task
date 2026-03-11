import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage._({
    super.key,
    required this.path,
    required this.isSvg,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.colorFilter,
    this.semanticsLabel,
  });

  final String path;
  final bool isSvg;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final ColorFilter? colorFilter;
  final String? semanticsLabel;

  factory AppImage.asset(
    String path, {
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    BlendMode? colorBlendMode,
    String? semanticsLabel,
  }) {
    return AppImage._(
      key: key,
      path: path,
      isSvg: false,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
    );
  }

  factory AppImage.svg(
    String path, {
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    ColorFilter? colorFilter,
    String? semanticsLabel,
  }) {
    return AppImage._(
      key: key,
      path: path,
      isSvg: true,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorFilter:
          colorFilter ??
          (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
      semanticsLabel: semanticsLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter: colorFilter,
        semanticsLabel: semanticsLabel,
      );
    }
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticLabel: semanticsLabel,
    );
  }
}
