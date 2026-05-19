import 'package:karigar/export.dart';

class ProfileDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileDetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: kcTextLightGrey),
          horizontalSpaceSmall,
          CustomText(text: label, fontSize: 12, color: kcTextGreyColor),
          const Spacer(),
          Expanded(
            flex: 2,
            child: CustomText(
              text: value,
              fontSize: 12,
              color: kcBlackColor,
              variant: TextVariant.medium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
