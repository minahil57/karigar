import 'package:karigar/export.dart';
import 'package:karigar/widgets/custom_skeleton.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());

    return GetBuilder<ProfileController>(
      builder: (controller) {
        final provider = controller.provider ?? dummyProvider;

        return CustomLayout(
          child: CustomSkeleton(
            enabled: controller.isLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  controller.isUser
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: kcWhitecolor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Iconsax.arrow_left,
                                    color: kcBlackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ProfileInfoCard(
                    provider: provider,
                    isUser: controller.isUser,
                  ),
                  verticalSpaceLarge,
                  _buildSection(
                    context,
                    children: [
                      ProfileDetailItem(
                        icon: Iconsax.briefcase,
                        label: 'Experience',
                        value:
                            provider.experienceYears?.toString() ?? '— Years',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.calendar,
                        label: 'Member Since',
                        value: provider.createdAt.year.toString(),
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.call,
                        label: 'Phone',
                        value: provider.phone ?? '—',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.sms,
                        label: 'Email',
                        value: provider.email ?? '—',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.location,
                        label: 'Service Areas',
                        value:
                            '${provider.address.city}, ${provider.address.state}',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.global,
                        label: 'Languages',
                        value: provider.languages?.toString() ?? '—',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.user,
                        label: 'About Me',
                        value:
                            provider.about?.toString() ??
                            'No description provided.',
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  ProfileStatsRow(provider: provider),
                  verticalSpaceMedium,

                  if (controller.isUser)
                    GestureDetector(
                      onTap: () => controller.logout(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.logout,
                              color: Colors.red,
                              size: 20,
                            ),
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
          ),
        );
      },
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
