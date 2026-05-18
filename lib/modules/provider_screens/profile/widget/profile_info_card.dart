import 'package:karigar/export.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProviderData provider;
  final bool isUser;

  const ProfileInfoCard({
    super.key,
    required this.provider,
    this.isUser = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kcPrimaryColor.withValues(alpha: 0.1),
                  width: 4,
                ),
              ),
              child: CustomCacheImage(
                height: 100,
                width: 100,
                imageUrl: provider.avatar ?? "",
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: CustomText(
                text: provider.businessName,
                variant: TextVariant.bold,
                fontSize: 18,
                color: kcBlackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (provider.isVerified) ...[
              horizontalSpaceTiny,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: kcSecondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: kcSecondaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Iconsax.shield_tick,
                      color: kcSecondaryColor,
                      size: 10,
                    ),
                    horizontalSpaceTiny,
                    CustomText(
                      text: AppStrings.verified,
                      fontSize: 9,
                      color: kcSecondaryColor,
                      variant: TextVariant.medium,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        CustomText(
          text: provider.specialty?.toString() ?? 'General Technician',
          fontSize: 12,
          color: kcTextGreyColor,
        ),
        verticalSpaceTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.star1, color: Colors.amber, size: 14),
            horizontalSpaceTiny,
            CustomText(
              text: '${provider.rating} (${provider.reviewCount} reviews)',
              fontSize: 11,
              color: kcTextGreyColor,
              variant: TextVariant.medium,
            ),
          ],
        ),
        verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: (provider.isAvailable ? Colors.green : Colors.grey)
                .withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: provider.isAvailable ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpaceTiny,
              CustomText(
                text: provider.isAvailable ? 'Available' : 'Unavailable',
                fontSize: 10,
                color: provider.isAvailable ? Colors.green : Colors.grey,
                variant: TextVariant.medium,
              ),
            ],
          ),
        ),
        if (isUser) ...[
          verticalSpaceSmall,
          GestureDetector(
            onTap: () {
              // Edit profile action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: kcPrimaryColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.edit, color: kcWhitecolor, size: 16),
                  horizontalSpaceTiny,
                  CustomText(
                    text: 'Edit Profile',
                    variant: TextVariant.medium,
                    fontSize: 12,
                    color: kcWhitecolor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
