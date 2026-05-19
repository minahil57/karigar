import 'package:karigar/export.dart';

class CustomerProfileView extends StatelessWidget {
  const CustomerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerProfileController());
    return GetBuilder<CustomerProfileController>(
      builder: (controller) {
        return CustomLayout(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kcWhitecolor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kcborderColor.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kcBlackColor.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: controller.user?.name ?? 'Customer Name',
                        variant: TextVariant.bold,
                        fontSize: 20,
                        color: kcBlackColor,
                      ),
                      verticalSpaceSmall,
                      Row(
                        spacing: 10.w,
                        children: [
                          const Icon(
                            Iconsax.sms,
                            size: 14,
                            color: kcTextGreyColor,
                          ),
                          CustomText(
                            text:
                                controller.user?.email ??
                                'customer@example.com',
                            fontSize: 12,
                            color: kcTextGreyColor,
                          ),
                        ],
                      ),
                      if (controller.user?.name != null) ...[
                        verticalSpaceTiny,
                        Row(
                          spacing: 10.w,
                          children: [
                            const Icon(
                              Iconsax.key,
                              size: 14,
                              color: kcTextGreyColor,
                            ),
                            CustomText(
                              text: controller.user!.role.capitalizeFirst!,
                              fontSize: 12,
                              color: kcTextGreyColor,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                verticalSpaceMedium,

                // Location Details Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.yourLocation,
                      variant: TextVariant.medium,
                      fontSize: 14,
                      color: kcBlackColor,
                    ),
                    if (controller.isLoadingAddress)
                      SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            kcSecondaryColor,
                          ),
                        ),
                      )
                    else
                      InkWell(
                        onTap: () => controller.fetchCurrentAddress(),
                        child: Icon(
                          Iconsax.refresh,
                          size: 14,
                          color: kcTextGreyColor,
                        ),
                      ),
                  ],
                ),
                verticalSpaceSmall,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: kcWhitecolor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kcborderColor.withValues(alpha: 0.6),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kcBlackColor.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.location5,
                        color: kcTextGreyColor,
                        size: 20,
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: CustomText(
                          text: controller.currentAddress,
                          fontSize: 12,
                          color: kcTextGreyColor,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,

                // Settings & Preferences
                CustomText(
                  text: AppStrings.preferences,
                  variant: TextVariant.medium,
                  fontSize: 14,
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                _buildOptionTile(
                  icon: Iconsax.global,
                  title: LocalizationService.isUrdu
                      ? 'English (Switch)'
                      : 'اردو (تبدیل کریں)',
                  onTap: () {
                    final newLang = LocalizationService.isUrdu ? 'en' : 'ur';
                    LocalizationService.changeLocale(newLang);
                  },
                ),
                _buildOptionTile(
                  icon: Iconsax.notification,
                  title: 'Bookings',
                  onTap: () {
                    Get.toNamed(Routes.customerBookings);
                  },
                ),
                verticalSpaceMedium,
                CustomText(
                  text: AppStrings.support,
                  variant: TextVariant.medium,
                  fontSize: 14,
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                _buildOptionTile(
                  icon: Iconsax.message_question,
                  title: AppStrings.helpSupport,
                  onTap: () {},
                ),
                _buildOptionTile(
                  icon: Iconsax.shield_tick,
                  title: AppStrings.privacyPolicy,
                  onTap: () {},
                ),
                verticalSpaceSmall,

                // Account Actions
                const Divider(color: kcborderColor),
                verticalSpaceMedium,
                _buildActionTile(
                  icon: Iconsax.logout,
                  title: AppStrings.logout,
                  color: kcTextGreyColor,
                  onTap: controller.logout,
                ),
                verticalSpaceSmall,
                _buildActionTile(
                  icon: Iconsax.trash,
                  title: AppStrings.deleteAccount,
                  color: kcErrorColor,
                  onTap: () => _showDeleteConfirmation(context, controller),
                ),
                verticalSpaceSmall,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kcPrimaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: kcPrimaryColor, size: 20),
            ),
            horizontalSpaceMedium,
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 12,
                variant: TextVariant.medium,
                color: kcBlackColor,
              ),
            ),
            RotatedBox(
              quarterTurns: LocalizationService.isUrdu ? 2 : 0,
              child: const Icon(
                Iconsax.arrow_right_3,
                size: 16,
                color: kcTextGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18.sp),
            horizontalSpaceMedium,
            CustomText(
              text: title,
              variant: TextVariant.bold,
              fontSize: 12,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    CustomerProfileController controller,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kcErrorColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.warning_2,
                  color: kcErrorColor,
                  size: 32,
                ),
              ),
              verticalSpaceMedium,
              CustomText(
                text: AppStrings.deleteAccountQuestion,
                variant: TextVariant.bold,
                fontSize: 18,
                color: kcBlackColor,
              ),
              verticalSpaceSmall,
              CustomText(
                text: AppStrings.deleteAccountWarning,
                fontSize: 14,
                color: kcTextGreyColor,
                textAlign: TextAlign.center,
              ),
              verticalSpaceLarge,
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      text: AppStrings.cancel,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  horizontalSpaceMedium,
                  Expanded(
                    child: CustomOutlineButton(
                      textColor: kcErrorColor,
                      text: AppStrings.delete,
                      borderColor: kcErrorColor,
                      onPressed: () {
                        Get.back();
                        controller.deleteAccount();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
