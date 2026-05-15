import 'package:karigar/export.dart';

ThemeData get theme => AppTheme.theme;

abstract final class AppTheme {
  static ThemeType themeType = ThemeType.light;
  static TextDirection textDirection = TextDirection.rtl;
  static ThemeData theme = getTheme();



  static ThemeData getTheme([ThemeType? themeType]) {
    themeType = themeType ?? AppTheme.themeType;
    if (themeType == ThemeType.light) return lightTheme;
    return darkTheme;
  }

  /// -------------------------- Light Theme  -------------------------------------------- ///
  static final ThemeData lightTheme = ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Primary Color
    primaryColor: kcPrimaryColor,
    scaffoldBackgroundColor: kcBackgroundColor,
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: kcWhitecolor,
      iconTheme: IconThemeData(color: kcWhitecolor),
      actionsIconTheme: IconThemeData(color: kcBlackColor),
    ),

    /// Card Theme
    cardTheme: const CardThemeData(color: Color(0xfff0f0f0)),
    cardColor: const Color(0xfff0f0f0),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.aBeeZee(),
      bodyLarge: GoogleFonts.abel(),
    ),


    /// Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xffe8e8e8),
      thickness: 1,
    ),
    dividerColor: const Color(0xffe8e8e8),

    /// Bottom AppBar Theme
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xffeeeeee),
      elevation: 2,
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffabb3ea);
        }
        return null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffD17E0F);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xffD17E0F),
      inactiveTrackColor: const Color(0xffD17E0F).withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4,
      thumbColor: const Color(0xffD17E0F),
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: Color(0xffeeeeee)),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),

    highlightColor: const Color(0xffeeeeee),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffD17E0F))
        .copyWith(surface: const Color(0xffffffff))
        .copyWith(error: const Color(0xfff0323c)),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData(
    /// Brightness
    brightness: Brightness.dark,

    /// Primary Color
    primaryColor: kcPrimaryColor,

    /// Scaffold and Background color
    scaffoldBackgroundColor: kcWhitecolor,
    canvasColor: Colors.white,

    /// AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: kcWhitecolor,
      iconTheme: IconThemeData(color: kcBlackColor),
      actionsIconTheme: IconThemeData(color: kcBlackColor),
    ),

    /// Card Theme
    cardTheme: const CardThemeData(color: Color(0xff222327)),
    cardColor: const Color(0xff222327),

    /// Input (Text-Field) Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kcWhitecolor,
      filled: true,
      hintStyle: getRegularStyle(color: kcTextGreyColor),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kcBlackColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kcBlackColor),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    ),

    /// Divider Color
    dividerTheme: const DividerThemeData(
      color: Color(0xff363636),
      thickness: 1,
    ),
    dividerColor: const Color(0xff363636),

    /// Tab bar Theme
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: kcTextGreyColor,
      labelColor: kcPrimaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: kcPrimaryColor, width: 2),
      ),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return kcWhitecolor;
        }
        return null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return kcPrimaryColor;
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xffD17E0F),
      inactiveTrackColor: const Color(0xffD17E0F).withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4,
      thumbColor: const Color(0xffD17E0F),
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),

    ///Other Color
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffD17E0F),
      brightness: Brightness.dark,
    ).copyWith(surface: const Color(0xff161616)).copyWith(error: Colors.orange),
  );
}
