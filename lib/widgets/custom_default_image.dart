import 'package:karigar/export.dart';

class CustomDefaultImage extends StatelessWidget {
  const CustomDefaultImage({
    super.key,
    required this.name,
    required this.height,
    required this.width,
    required this.borderRadius,
  });

  final String name;
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      List<String> nameParts = name.split(' ');
      String initials = '';
      for (var part in nameParts) {
        if (part.isNotEmpty) {
          initials += part[0];
          if (initials.length == 2) break;
        }
      }
      return initials.toUpperCase();
    }

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: kcLightGrey, borderRadius: borderRadius),
      child: CustomText(
        text: getInitials(name),
        fontSize: 14,
        color: kcBlackColor,
      ),
    );
  }
}
