import 'package:karigar/export.dart';

class ProviderCard extends StatelessWidget {
  final ProviderData provider;
  final VoidCallback? onTap;

  const ProviderCard({super.key, required this.provider, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kcborderColor),
          boxShadow: [
            BoxShadow(
              color: kcBlackColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: provider.avatar ?? '',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            horizontalSpaceSmall,
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: provider.businessName,
                          fontSize: 16,
                          variant: TextVariant.medium,
                          color: kcTextBlackcolor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (provider.isVerified)
                        const Icon(
                          Iconsax.shield_tick,
                          color: kcSecondaryColor,
                          size: 16,
                        ),
                    ],
                  ),
                  verticalSpaceTiny,
                  CustomText(
                    text: provider.specialty ?? 'General Service',
                    fontSize: 13,
                    color: kcTextGreyColor,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      const Icon(Iconsax.star1, color: Colors.amber, size: 14),
                      horizontalSpaceTiny,
                      CustomText(
                        text: '${provider.rating} (${provider.reviewCount})',
                        fontSize: 12,
                        variant: TextVariant.medium,
                        color: kcTextBlackcolor,
                      ),
                      horizontalSpaceMedium,
                      const Icon(
                        Iconsax.location,
                        color: kcTextGreyColor,
                        size: 14,
                      ),
                      horizontalSpaceTiny,
                      Expanded(
                        child: CustomText(
                          text: provider.address.city,
                          fontSize: 12,
                          color: kcTextGreyColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow
            const Icon(Iconsax.arrow_right_3, color: kcTextGreyColor, size: 18),
          ],
        ),
      ),
    );
  }
}
