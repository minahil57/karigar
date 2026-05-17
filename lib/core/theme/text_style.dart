import 'package:karigar/export.dart';

enum TextVariant { regular, medium, bold }

TextStyle appTextStyle({
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  final TextStyle baseStyle = TextStyle(
    fontFamily: 'Sora',
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
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
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}

TextStyle getMediumStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 14,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}

TextStyle getRegularStyle({
  Color color = kcTextBlackcolor,
  double fontSize = 12,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
}) {
  return appTextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w400,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
  );
}
