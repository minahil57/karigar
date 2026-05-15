import 'package:karigar/export.dart';

abstract final class UIConstants {
  static const double containerRadius = 4;
  static const double cardRadius = 4;
  static const double buttonRadius = 4;

  static VisualDensity getCompactDensity = const VisualDensity(
    horizontal: -4,
    vertical: -4,
  );

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      strokeAlign: 0,
      color: theme.colorScheme.onSurface.withAlpha(80),
    ),
  );

  static OutlineInputBorder focusedInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: theme.colorScheme.primary),
  );

  static double formInputFieldSpacing = 4;

  static OutlineInputBorder formFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(3),
    borderSide: BorderSide(color: theme.dividerColor),
  );
}
