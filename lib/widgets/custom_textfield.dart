import 'package:karigar/export.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isFilled;
  final Color fillColor;
  final Color borderColor;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isFilled = true,
    this.fillColor = kcWhitecolor,
    this.borderColor = kcborderColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kcSecondaryColor,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
      style: getRegularStyle(color: kcBlackColor, fontSize: 10),
      decoration: InputDecoration(
        hintText: hintText,
        filled: isFilled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
            counterText: maxLength != null ? "" : null,
        hintStyle: getRegularStyle(color: kcTextGreyColor, fontSize: 10),

        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.h),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: borderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: kcErrorColor),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: kcErrorColor, width: 1.5),
        ),
      ),
    );
  }
}
