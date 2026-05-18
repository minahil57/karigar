import 'package:karigar/export.dart';

enum TextVariant { regular, medium, bold }

TextStyle appTextStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w500,
  double? height,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  final TextStyle baseStyle = TextStyle(
    fontFamily: 'Sora',
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: height,
  );

  return baseStyle.copyWith(
    color: color,
    decoration: decoration,
    decorationColor: decorationColor ?? color,
    decorationStyle: decorationStyle,
  );
}

TextStyle getBoldStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 24,
  double? height,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}

TextStyle getMediumStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 14,
  double? height,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w500,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}

TextStyle getRegularStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 12,
  double? height,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w400,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}
