import '../../export.dart';

const double _tinySize = 5;
const double _smallSize = 10;
const double _mediumSize = 25;
const double _largeSize = 50;
const double _massiveSize = 120;

Widget get horizontalSpaceTiny => SizedBox(width: _tinySize.w);
Widget get horizontalSpaceSmall => SizedBox(width: _smallSize.w);
Widget get horizontalSpaceMedium => SizedBox(width: _mediumSize.w);
Widget get horizontalSpaceLarge => SizedBox(width: _largeSize.w);
Widget horizontalSpace(double widths) => SizedBox(width: widths.w);

Widget get verticalSpaceTiny => SizedBox(height: _tinySize.h);
Widget get verticalSpaceSmall => SizedBox(height: _smallSize.h);
Widget get verticalSpaceMedium => SizedBox(height: _mediumSize.h);
Widget get verticalSpaceLarge => SizedBox(height: _largeSize.h);
Widget get verticalSpaceMassive => SizedBox(height: _massiveSize.h);

Widget get spacedDivider => Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.h),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height.h);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) => min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) => min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 10, max: 14);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(
  BuildContext context, {
  double? fontSize,
  double? max,
}) {
  double width = screenWidth(context);
  // Using 400 as base to make fonts slightly smaller on standard phones
  double scale = width / 400;
  double responsiveSize = (fontSize ?? 16) * scale;

  if (max != null && responsiveSize > max) {
    return max;
  }

  // Ensure it doesn't get smaller than 80% of the original size on tiny screens
  return maxSafe(responsiveSize, (fontSize ?? 16) * 0.8);
}

double maxSafe(double a, double b) => a > b ? a : b;
