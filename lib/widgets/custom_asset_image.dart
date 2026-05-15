import 'package:karigar/export.dart';

class CustomAssetsImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final BlendMode? blendMode;

  const CustomAssetsImage({
    super.key,
    required this.imagePath,
    this.height = 20,
    this.width = 20,
    this.fit = BoxFit.contain,
    this.color,
    this.blendMode,
  });

  bool get isSvg => imagePath.contains('.svg');

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcATop)
                : null,
          )
        : Image.asset(
            imagePath,
            height: height,
            width: width,
            colorBlendMode: blendMode,
            fit: fit,
            color: color,
          );
  }
}
