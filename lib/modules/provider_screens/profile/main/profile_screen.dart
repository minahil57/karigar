import 'package:karigar/export.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return CustomLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            verticalSpaceSmall,
            ProfileHeader(title: 'Profile', onEdit: () {}),
            verticalSpaceMedium,
            ProfileInfoCard(profile: controller.profile),
            verticalSpaceLarge,
            _buildSection(
              context,
              children: [
                ProfileDetailItem(
                  icon: Iconsax.briefcase,
                  label: 'Experience',
                  value: controller.profile.experience,
                ),
                ProfileDetailItem(
                  icon: Iconsax.calendar,
                  label: 'Member Since',
                  value: controller.profile.memberSince,
                ),
                ProfileDetailItem(
                  icon: Iconsax.call,
                  label: 'Phone',
                  value: controller.profile.phone,
                ),
                ProfileDetailItem(
                  icon: Iconsax.sms,
                  label: 'Email',
                  value: controller.profile.email,
                ),
                ProfileDetailItem(
                  icon: Iconsax.location,
                  label: 'Service Areas',
                  value: controller.profile.serviceAreas,
                ),
                ProfileDetailItem(
                  icon: Iconsax.global,
                  label: 'Languages',
                  value: controller.profile.languages,
                ),
                ProfileDetailItem(
                  icon: Iconsax.user,
                  label: 'About Me',
                  value: controller.profile.aboutMe,
                ),
              ],
            ),
            verticalSpaceMedium,
            _buildSection(
              context,
              children: [ProfileSkillsChips(skills: controller.profile.skills)],
            ),
            verticalSpaceMedium,
            ProfileStatsRow(profile: controller.profile),
            verticalSpaceMedium,

            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.logout, color: Colors.red, size: 20),
                    horizontalSpaceSmall,
                    const CustomText(
                      text: AppStrings.logout,
                      variant: TextVariant.bold,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
      ),
      child: Column(children: children),
    );
  }
}
