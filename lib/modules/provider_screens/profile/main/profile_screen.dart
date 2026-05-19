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
                                  child: RotatedBox(
                                    quarterTurns: LocalizationService.isUrdu
                                        ? 2
                                        : 0,
                                    child: const Icon(
                                      Iconsax.arrow_left,
                                      color: kcBlackColor,
                                      size: 20,
                                    ),
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
                        label: AppStrings.experience,
                        value:
                            '${provider.experienceYears?.toString() ?? '—'} ${AppStrings.experienceYearsLabel}',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.calendar,
                        label: AppStrings.memberSince,
                        value: provider.createdAt.year.toString(),
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.call,
                        label: AppStrings.phone,
                        value: provider.phone ?? '—',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.sms,
                        label: AppStrings.email,
                        value: provider.email ?? '—',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.location,
                        label: AppStrings.serviceAreasLabel,
                        value:
                            '${provider.address.city}, ${provider.address.state}',
                      ),
                      ProfileDetailItem(
                        icon: Iconsax.global,
                        label: AppStrings.languagesSpoken,
                        value: provider.languages.isNotEmpty
                            ? provider.languages.join(', ')
                            : '—',
                      ),
                      GestureDetector(
                        onTap: () {
                          final newLang = LocalizationService.isUrdu
                              ? 'en'
                              : 'ur';
                          LocalizationService.changeLocale(newLang);
                        },
                        child: ProfileDetailItem(
                          icon: Iconsax.global,
                          label: AppStrings.selectLanguage,
                          value: LocalizationService.isUrdu
                              ? 'English (Switch)'
                              : 'اردو (تبدیل کریں)',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.h,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Iconsax.user,
                                  size: 16,
                                  color: kcTextLightGrey,
                                ),
                                horizontalSpaceSmall,
                                CustomText(
                                  text: AppStrings.aboutMe,
                                  fontSize: 12,
                                  color: kcTextGreyColor,
                                ),
                              ],
                            ),
                            CustomText(
                              text:
                                  provider.about?.toString() ??
                                  AppStrings.noDescription,
                              fontSize: 12,
                              color: kcBlackColor,
                              variant: TextVariant.medium,
                            ),
                          ],
                        ),
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
                            CustomText(
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
