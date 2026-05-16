import 'package:karigar/export.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final bool isVerified;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.isVerified = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: kcBlackColor),
            horizontalSpaceMedium,
            CustomText(
              text: title,
              fontSize: 14,
              color: kcBlackColor,
              variant: TextVariant.medium,
            ),
            const Spacer(),
            if (isVerified) ...[
              CustomText(
                text: 'Verified',
                fontSize: 10,
                color: Colors.green,
                variant: TextVariant.medium,
              ),
              horizontalSpaceSmall,
            ],
            if (trailingText != null) ...[
              CustomText(
                text: trailingText!,
                fontSize: 12,
                color: kcTextLightGrey,
              ),
              horizontalSpaceSmall,
            ],
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: kcTextLightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
