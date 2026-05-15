
import 'package:karigar/export.dart';

abstract final class Snackbars {
  // ✅ SUCCESS
  static void success(String message) {
    _showGradient(
      message: message,
      icon: Icons.check_circle,
      iconColor: Colors.green,
      borderGradient: [
        Color(0xFF1E9E63).withValues(alpha: 0.35), // Light green
        Color(0xFF1E9E63), // Dark green
      ],

      backgroundGradient: [Color(0xFFE8F9F0), Color(0xFFF5FFF9)],
    );
  }

  // ❌ ERROR
  static void error(String message) {
    _showGradient(
      message: message,
      icon: Icons.error_outline_rounded,
      iconColor: kcErrorColor,
      borderGradient: [Color(0xFFFFC0C0), Color(0xFFFF7373)],
      backgroundGradient: [Color(0xFFFFDFDF), Color(0xFFFFF5F5)],
    );
  }

  // ⚠️ WARNING
  static void warning(String message) {
    _showGradient(
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
      borderGradient: [
        // Dark orange
        Color(0xFFF57C00).withValues(alpha: 0.4),
        Color(0xFFF57C00), // Light orange
      ],

      backgroundGradient: [Color(0xFFFFF1D6), Color(0xFFFFFAEE)],
    );
  }

  // ℹ️ INFO
  static void info(String message) {
    _showGradient(
      message: message,
      icon: Icons.info_outline,
      iconColor: kcPrimaryColor,
      borderGradient: [kcPrimaryColor.withValues(alpha: 0.4), kcPrimaryColor],

      backgroundGradient: [Color(0xFFEAF2FF), Color(0xFFF5F9FF)],
    );
  }

  // Common helpers
  static void somethingWentWrong() {
    error(AppStrings.somethingWentWrong.tr);
  }

  static void expiredSession() {
    warning(AppStrings.sessionExpired.tr);
  }

  static void copyToClipboard() {
    info(AppStrings.copiedToClipboard.tr);
  }

  static void _showGradient({
    required String message,
    required List<Color> borderGradient,
    required List<Color> backgroundGradient,
    required IconData icon,
    required Color iconColor,
  }) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      barBlur: 10,
      overlayBlur: 1,
      shouldIconPulse: false,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      messageText: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: borderGradient),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(1.5), // BORDER THICKNESS
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: backgroundGradient,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              horizontalSpace(12),
              Expanded(
                child: CustomText(
                  text: message,
                  fontSize: 12,
                  color: kcDarkTextColor,
                  variant: TextVariant.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
