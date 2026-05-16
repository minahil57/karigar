import 'package:karigar/export.dart';

class ProviderProfileCard extends StatelessWidget {
  final ProviderData provider;
  final VoidCallback? onTap;

  const ProviderProfileCard({
    super.key,
    required this.provider,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: kcPrimaryColor.withValues(alpha: 0.3),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kcSecondaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: CachedNetworkImageProvider(provider.avatar ?? ''),
                        backgroundColor: kcborderColor,
                      ),
                    ),
                    if (provider.isAvailable)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(color: kcPrimaryColor, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CustomText(
                              text: provider.businessName,
                              variant: TextVariant.bold,
                              fontSize: 16,
                              color: kcWhitecolor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (provider.isVerified) ...[
                            horizontalSpaceSmall,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: kcSecondaryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: kcSecondaryColor.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Iconsax.shield_tick,
                                    color: kcSecondaryColor,
                                    size: 12,
                                  ),
                                  horizontalSpaceTiny,
                                  CustomText(
                                    text: AppStrings.verified,
                                    variant: TextVariant.medium,
                                    fontSize: 10,
                                    color: kcSecondaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      CustomText(
                        text: provider.specialty?.toString() ?? 'Service Provider',
                        color: kcWhitecolor.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                      verticalSpaceTiny,
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star1,
                            color: Colors.amber,
                            size: 12,
                          ),
                          horizontalSpaceTiny,
                          CustomText(
                            text: provider.rating.toString(),
                            variant: TextVariant.medium,
                            color: kcWhitecolor,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: StatItem(
                    icon: Iconsax.briefcase,
                    label: AppStrings.jobs,
                    value: '—',
                    trend: '+0 this month',
                  ),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: StatItem(
                    icon: Iconsax.wallet,
                    label: AppStrings.earnings,
                    value: '₹0',
                    trend: '+0% this month',
                    iconColor: Colors.amber,
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kcWhitecolor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kcWhitecolor.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kcSecondaryColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Iconsax.calendar_tick,
                      color: kcSecondaryColor,
                      size: 20,
                    ),
                  ),
                  horizontalSpaceSmall,
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.activeBooking,
                          color: kcWhitecolor.withValues(alpha: 0.5),
                          fontSize: 9,
                        ),
                        CustomText(
                          text: 'No active bookings',
                          variant: TextVariant.medium,
                          color: kcWhitecolor,
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String trend;
  final Color? iconColor;

  const StatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.trend,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcWhitecolor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: (iconColor ?? kcSecondaryColor).withValues(alpha: 0.8),
                size: 16,
              ),
              horizontalSpaceTiny,
              CustomText(
                text: label,
                color: kcWhitecolor.withValues(alpha: 0.5),
                fontSize: 9,
              ),
            ],
          ),
          verticalSpaceSmall,
          CustomText(
            text: value,
            variant: TextVariant.bold,
            fontSize: 15,
            color: kcWhitecolor,
          ),
          verticalSpaceTiny,
          CustomText(
            text: trend,
            variant: TextVariant.medium,
            color: iconColor ?? kcSecondaryColor,
            fontSize: 9,
          ),
        ],
      ),
    );
  }
}
