import 'package:karigar/export.dart';

class ProviderCard extends StatelessWidget {
  final ProviderData provider;
  final VoidCallback? onTap;

  const ProviderCard({super.key, required this.provider, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () => Get.toNamed(
            Routes.providerProfile,
            arguments: {'providerId': provider.userId},
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: kcBlackColor.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        kcSecondaryColor,
                        kcSecondaryColor.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: provider.avatar ?? '',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: kcborderColor),
                      errorWidget: (context, url, error) => Container(
                        color: kcborderColor,
                        child: const Icon(Icons.person, color: kcTextGreyColor),
                      ),
                    ),
                  ),
                ),
                if (provider.isAvailable)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: kcWhitecolor, width: 2.5),
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
                          fontSize: 16,
                          variant: TextVariant.bold,
                          color: const Color(0xFF1A3B5D),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (provider.isVerified) ...[
                        horizontalSpaceTiny,
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF2196F3),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                  verticalSpaceTiny,
                  CustomText(
                    text:
                        provider.specialty?.toString() ?? 'General Technician',
                    fontSize: 12,
                    color: kcTextGreyColor,
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      _buildMiniStat(
                        Iconsax.star1,
                        provider.rating.toString(),
                        Colors.amber,
                      ),
                      horizontalSpaceSmall,
                      _buildMiniStat(
                        Iconsax.location,
                        provider.address.city,
                        kcSecondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kcSecondaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    text: '${provider.responseTime}m away',
                    fontSize: 11,
                    variant: TextVariant.medium,
                    color: kcSecondaryColor,
                  ),
                ),
                verticalSpaceMedium,
                RotatedBox(
                  quarterTurns: LocalizationService.isUrdu ? 2 : 0,
                  child: const Icon(
                    Iconsax.arrow_right_3,
                    color: kcTextGreyColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String label, Color iconColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor),
        horizontalSpaceTiny,
        CustomText(
          text: label,
          fontSize: 12,
          variant: TextVariant.medium,
          color: const Color(0xFF1A3B5D),
        ),
      ],
    );
  }
}
