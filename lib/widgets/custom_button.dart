import 'package:karigar/export.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color foregroundColor;
  final Widget? icon;
  final Color borderColor;
  final double borderWidth;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final Size? minSize;
  final Size? maxSize;
  final bool? isEnabled;
  final bool isLoading;
  final Color? loaderColor;
  final bool showIconOnLeft;
  final double borderRadius;
  final double? height;
  final double? width;
  final double iconAndTitleGap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = kcWhitecolor,
    this.foregroundColor = kcBlackColor,
    this.icon,
    this.showIconOnLeft = false,
    this.borderColor = kcBlackColor,
    this.borderWidth = 1,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding,
    this.minSize,
    this.maxSize,
    this.isEnabled = true,
    this.isLoading = false,
    this.loaderColor,
    this.borderRadius = 100,
    this.height,
    this.width,
    this.iconAndTitleGap = 8,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled! ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(1.5), // Border thickness
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isEnabled! ? null : kcDisabledColor,
          gradient: isEnabled!
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kcPrimaryColor, Color(0xFF96C1FF)],
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: isEnabled! ? null : kcDisabledColor,
            gradient: isEnabled!
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kcPrimaryColor,
                      kcPrimaryColor.withValues(alpha: 0.9),
                      kcPrimaryColor.withValues(alpha: 0.5),
                    ],
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null && showIconOnLeft) ...[
                  icon!,
                  SizedBox(width: iconAndTitleGap),
                ],
                Text(
                  text,
                  style: getRegularStyle(
                    fontSize: fontSize,
                    color: isEnabled! ? textColor : kcTextLightGrey,
                  ),
                ),
                if (icon != null && !showIconOnLeft) ...[
                  SizedBox(width: iconAndTitleGap),
                  icon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
