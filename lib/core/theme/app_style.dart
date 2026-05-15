import 'package:karigar/export.dart';

class WidgetRadius {
  double xs;
  double small;
  double medium;
  double large;

  WidgetRadius({this.xs = 2, this.small = 4, this.medium = 6, this.large = 8});
}

class ColorGroup {
  final Color color;
  final Color onColor;

  ColorGroup(this.color, this.onColor);
}

class MainAppTheme {
  static ThemeData theme = MainAppTheme.getThemeFromThemeMode();
  static TextDirection textDirection = TextDirection.ltr;

  static Color primaryColor = const Color(0xffD17E0F);

  static ThemeData getThemeFromThemeMode() {
    return ThemeCustomizer.instance.theme == ThemeMode.light
        ? lightTheme
        : darkTheme;
  }

  /// -------------------------- Light Theme  -------------------------------------------- ///

  static final ThemeData lightTheme = ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Primary Color
    primaryColor: MainAppTheme.primaryColor,

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffF5F5F5),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(color: Color(0xff495057)),
    ),

    /// Card Theme
    cardTheme: const CardThemeData(color: Color(0xffffffff)),
    cardColor: const Color(0xffffffff),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffe5a10d)),

    snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.white),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MainAppTheme.primaryColor,
      splashColor: const Color(0xffeeeeee).withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: MainAppTheme.primaryColor,
      hoverColor: MainAppTheme.primaryColor,
      foregroundColor: const Color(0xffeeeeee),
    ),

    /// Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xffdddddd),
      thickness: 1,
    ),
    dividerColor: const Color(0xffdddddd),

    /// Bottom AppBar Theme
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xffeeeeee),
      elevation: 2,
    ),

    /// Tab bar Theme
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: const Color(0xff495057),
      labelColor: MainAppTheme.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: MainAppTheme.primaryColor, width: 2),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: MainAppTheme.primaryColor,
      inactiveTrackColor: MainAppTheme.primaryColor.withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4,
      thumbColor: MainAppTheme.primaryColor,
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: Color(0xffeeeeee)),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MainAppTheme.primaryColor;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? MainAppTheme.primaryColor
            : Colors.white,
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? MainAppTheme.primaryColor
            : null,
      ),
    ),

    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        Colors.grey.shade900.withValues(alpha: .6),
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),

    highlightColor: const Color(0xffeeeeee),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    /// Brightness

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff262729),
    canvasColor: Colors.transparent,

    primaryColor: const Color(0xff4ddada),

    /// AppBar Theme
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff262729)),

    /// Card Theme
    cardTheme: const CardThemeData(color: Color(0xff1b1b1c)),
    cardColor: const Color(0xff1b1b1c),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffe5a10d),
      surface: const Color(0xff262729),
      onSurface: const Color(0xFFD7D7D7),
      brightness: Brightness.dark,
    ),

    /// Input (Text-Field) Theme
    inputDecorationTheme: const InputDecorationTheme(),

    /// Divider Color
    dividerTheme: const DividerThemeData(
      color: Color(0xff393A41),
      thickness: 1,
    ),
    dividerColor: const Color(0xff393A41),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MainAppTheme.primaryColor,
      splashColor: Colors.white.withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: MainAppTheme.primaryColor,
      hoverColor: MainAppTheme.primaryColor,
      foregroundColor: Colors.white,
    ),

    /// Bottom AppBar Theme
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xff464c52),
      elevation: 2,
    ),

    /// Tab bar Theme
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: const Color(0xff495057),
      labelColor: MainAppTheme.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: MainAppTheme.primaryColor, width: 2),
      ),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: MainAppTheme.primaryColor,
      inactiveTrackColor: MainAppTheme.primaryColor.withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4,
      thumbColor: MainAppTheme.primaryColor,
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),

    ///Other Color
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: const Color(0xff47484b),
    splashColor: Colors.white.withAlpha(100),
  );

  static ThemeData createTheme(ThemeMode themeType, Color seedColor) {
    if (themeType == ThemeMode.light) {
      return lightTheme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      );
    }
    return darkTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
        onSurface: const Color(0xFFDAD9CA),
      ),
    );
  }
}

class AppStyle {
  static void init() {
    initMyStyle();
    
  }

  static void changeMyTheme() {
    My.changeTheme(MainAppTheme.theme);
  }

  static void initMyStyle() {
    
    My.changeTheme(MainAppTheme.theme);
  }

  /// -------------------------- Styles  -------------------------------------------- ///

  static WidgetRadius buttonRadius = WidgetRadius(small: 2, medium: 4);
  static WidgetRadius cardRadius = WidgetRadius(medium: 4);
  static WidgetRadius containerRadius = WidgetRadius(medium: 4);
  static WidgetRadius imageRadius = WidgetRadius(medium: 4);
}
