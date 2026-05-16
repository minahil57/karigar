import 'package:karigar/export.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final Color textColor;
  final double fontSize;
  final String? icon;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.backgroundColor = kcWhitecolor,
    this.borderColor = kcDisabledColor,
    this.borderRadius = 100,
    this.textColor = kcBlackColor,
    this.fontSize = 14,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomAssetsImage(
                  imagePath: icon!,
                  height: 20,
                  width: 20,
                  color: kcBlackColor,
                ),
              ),
            CustomText(
              text: text,
              fontSize: fontSize,
              variant: TextVariant.regular,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
