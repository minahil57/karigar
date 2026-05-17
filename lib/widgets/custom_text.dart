import 'package:karigar/export.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextVariant variant;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration decoration;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.variant = TextVariant.regular,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle() {
    switch (variant) {
      case TextVariant.bold:
        return getBoldStyle(
          fontSize: fontSize.sp,
          color: color ?? kcTextBlackcolor,
          decoration: decoration,
        );

      case TextVariant.medium:
        return getMediumStyle(
          fontSize: fontSize.sp,
          color: color ?? kcTextBlackcolor,
          decoration: decoration,
        );

      case TextVariant.regular:
        return getRegularStyle(
          fontSize: fontSize.sp,
          color: color ?? kcTextBlackcolor,
          decoration: decoration,
        );
    }
  }
}
