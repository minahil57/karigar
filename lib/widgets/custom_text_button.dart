import 'package:karigar/export.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color splashColor;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = kcSecondaryColor,
    this.splashColor = kcSecondaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Text(
        text,
        style: getRegularStyle(
          color: textColor,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
