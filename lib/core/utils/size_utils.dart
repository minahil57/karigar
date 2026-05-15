import 'package:karigar/export.dart';

class SizeUtils {
  static double get screenWidth => MediaQuery.of(Get.context!).size.width;

  static double get screenHeight => MediaQuery.of(Get.context!).size.height;

  static double get modalWidth => Get.context!.responsiveValue<double>(
    desktop: screenWidth * 0.4,
    tablet: screenWidth * 0.6,
    mobile: screenWidth * 0.9,
  );

  static double get pdfDisplayWidth => Get.context!.responsiveValue<double>(
    desktop: screenWidth * 0.55,
    tablet: screenWidth * 1,
    mobile: screenWidth * 1,
  );

  static double get accountsTreeWidth => Get.context!.responsiveValue<double>(
    desktop: screenWidth * 0.75,
    tablet: screenWidth,
    mobile: screenWidth,
  );

  static ItemsAlignment get mainHeaderAlignment =>
      Get.context!.responsiveValue<ItemsAlignment>(
        desktop: ItemsAlignment.row,
        tablet: ItemsAlignment.row,
        mobile: ItemsAlignment.column,
      );
}
