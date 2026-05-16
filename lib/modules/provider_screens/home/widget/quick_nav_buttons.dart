import 'package:karigar/export.dart';

class QuickNavButtons extends StatelessWidget {
  const QuickNavButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildNavButton(
            context,
            icon: Iconsax.clock,
            label: 'History',
            onTap: () => Get.toNamed(Routes.workHistory),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          child: _buildNavButton(
            context,
            icon: Iconsax.user,
            label: 'Profile',
            onTap: () => Get.toNamed(Routes.profile),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: kcBlackColor),
            horizontalSpaceSmall,
            CustomText(
              text: label,
              variant: TextVariant.medium,
              fontSize: 13,
              color: kcBlackColor,
            ),
          ],
        ),
      ),
    );
  }
}
