import 'package:karigar/export.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    this.height = 45,
    this.width = 45,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.name = '',
    this.fit = BoxFit.cover,
    this.isCacheNeeded = true,
    this.clip = true,
    this.showDefaultLoader = true,
  });

  final String imageUrl;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final String name;
  final BoxFit fit;
  final bool isCacheNeeded;
  final bool clip;
  final bool showDefaultLoader;

  @override
  Widget build(BuildContext context) {
    final image = isCacheNeeded
        ? CachedNetworkImage(
            errorWidget: (context, url, error) =>
                CustomErrorContainer(height: height),
            progressIndicatorBuilder: (context, url, progress) {
              if (!showDefaultLoader) return const SizedBox();
              return Container(
                height: height,
                width: width,
                color: kcLightGrey,
                child: const CustomLoader(height: 70, width: 70),
              );
            },
            fit: fit,
            imageUrl: imageUrl,
          )
        : Image.network(
            imageUrl,
            fit: fit,
            errorBuilder: (context, error, stackTrace) =>
                CustomErrorContainer(height: height),
            loadingBuilder: (context, child, loadingProgress) {
              if (!showDefaultLoader) return const SizedBox();
              if (loadingProgress == null) return child;
              return Container(
                height: height,
                width: width,
                color: kcLightGrey,
                child: const CustomLoader(height: 70, width: 70),
              );
            },
          );

    if (imageUrl.isEmpty) {
      return CustomDefaultImage(
        name: name,
        height: height,
        width: width,
        borderRadius: borderRadius ?? BorderRadius.circular(50),
      );
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: borderRadius,
      ),
      child: clip && borderRadius != null
          ? ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.zero,
              child: image,
            )
          : image,
    );
  }
}
