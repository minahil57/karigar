import 'package:karigar/export.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileInfoCard({
    super.key,
    required this.profile,
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
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profile.profileImageUrl),
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: kcPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.camera,
                  color: kcWhitecolor,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: profile.name,
              variant: TextVariant.bold,
              fontSize: 18,
              color: kcBlackColor,
            ),
            if (profile.isVerified) ...[
              horizontalSpaceTiny,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: kcSecondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: kcSecondaryColor.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Iconsax.shield_tick, color: kcSecondaryColor, size: 10),
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
          text: profile.profession,
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
              text: '${profile.rating} (${profile.reviews})',
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
            color: Colors.green.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpaceTiny,
              CustomText(
                text: profile.status,
                fontSize: 10,
                color: Colors.green,
                variant: TextVariant.medium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
