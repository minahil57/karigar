import 'package:karigar/export.dart';

class ProviderMapCard extends StatelessWidget {
  final ProviderData provider;
  final VoidCallback onDismiss;

  const ProviderMapCard({
    super.key,
    required this.provider,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: kcBlackColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle / close ──────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 28),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: kcborderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              GestureDetector(
                onTap: onDismiss,
                child: const Icon(
                  Iconsax.close_circle,
                  size: 24,
                  color: kcTextGreyColor,
                ),
              ),
            ],
          ),
          verticalSpaceSmall,

          // ── Avatar + info ────────────────────────────────────
          Row(
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
                        height: 64,
                        width: 64,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => Container(color: kcborderColor),
                        errorWidget: (_, _, _) => Container(
                          color: kcborderColor,
                          child: const Icon(
                            Icons.person,
                            color: kcTextGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (provider.isAvailable)
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(color: kcWhitecolor, width: 2),
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
                          provider.specialty?.toString() ??
                          'General Technician',
                      fontSize: 12,
                      color: kcTextGreyColor,
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        _miniStat(
                          Iconsax.star1,
                          provider.rating.toString(),
                          Colors.amber,
                        ),
                        horizontalSpaceSmall,
                        _miniStat(
                          Iconsax.location,
                          provider.address.city,
                          kcSecondaryColor,
                        ),
                        horizontalSpaceSmall,
                        _miniStat(
                          Iconsax.clock,
                          '${provider.responseTime}m',
                          kcSecondaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),

          // ── See Full Details button ──────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                AppLayout.of(context)?.changeTab(1);
                Get.find<AgentController>().sendMessage(customText: 'Book me the ${provider.businessName} for ${provider.specialty?.toString()}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                foregroundColor: kcWhitecolor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const CustomText(
                text: 'Book  Now',
                fontSize: 14,
                variant: TextVariant.bold,
                color: kcWhitecolor,
              ),
            ),
          ),
          verticalSpaceSmall,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(
                Routes.providerProfile,
                arguments: {'providerId': provider.userId},
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcSecondaryColor,
                foregroundColor: kcWhitecolor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const CustomText(
                text: 'See Full Details',
                fontSize: 14,
                variant: TextVariant.bold,
                color: kcWhitecolor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStat(IconData icon, String label, Color iconColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: iconColor),
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
