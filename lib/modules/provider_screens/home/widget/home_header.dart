import 'package:karigar/export.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onLogout;
  const HomeHeader({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.appTitle,
                fontSize: getResponsiveFontSize(context, fontSize: 24, max: 28),
                variant: TextVariant.bold,
              ),
              CustomText(
                text: AppStrings.aiPoweredMarketplace,
                color: kcTextLightGrey,
                fontSize: getResponsiveFontSize(context, fontSize: 10, max: 12),
              ),
            ],
          ),
          GestureDetector(
            onTap: onLogout,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: kcWhitecolor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kcborderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.logout,
                    size: getResponsiveFontSize(context, fontSize: 14, max: 16),
                    color: kcDarkTextColor,
                  ),
                  horizontalSpaceTiny,
                  CustomText(
                    text: AppStrings.logout,
                    variant: TextVariant.medium,
                    fontSize: getResponsiveFontSize(
                      context,
                      fontSize: 10,
                      max: 12,
                    ),
                    color: kcDarkTextColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
