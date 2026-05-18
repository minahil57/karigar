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
                        fontSize: 24,
                        color: kcBlackColor,
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          const Icon(
                            Iconsax.sms,
                            size: 16,
                            color: kcTextGreyColor,
                          ),
                          horizontalSpaceTiny,
                          CustomText(
                            text:
                                controller.user?.email ??
                                'customer@example.com',
                            fontSize: 14,
                            color: kcTextGreyColor,
                          ),
                        ],
                      ),
                      if (controller.user?.name != null) ...[
                        verticalSpaceTiny,
                        Row(
                          children: [
                            const Icon(
                              Iconsax.call,
                              size: 16,
                              color: kcTextGreyColor,
                            ),
                            horizontalSpaceTiny,
                            CustomText(
                              text: controller.user!.role,
                              fontSize: 14,
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
                CustomText(
                  text: 'Your Location',
                  variant: TextVariant.bold,
                  fontSize: 18,
                  color: kcBlackColor,
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
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kcSecondaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.location5,
                          color: kcSecondaryColor,
                          size: 24,
                        ),
                      ),
                      horizontalSpaceMedium,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: 'Current Address',
                              variant: TextVariant.bold,
                              fontSize: 14,
                              color: kcBlackColor,
                            ),
                            verticalSpaceTiny,
                            if (controller.isLoadingAddress)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(kcSecondaryColor),
                                  ),
                                ),
                              )
                            else
                              CustomText(
                                text: controller.currentAddress,
                                fontSize: 13,
                                color: kcTextGreyColor,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      horizontalSpaceSmall,
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: const Icon(
                              Iconsax.refresh,
                              size: 20,
                              color: kcTextGreyColor,
                            ),
                            onPressed: controller.isLoadingAddress
                                ? null
                                : () => controller.fetchCurrentAddress(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,

                // Settings & Preferences
                CustomText(
                  text: 'Preferences',
                  variant: TextVariant.bold,
                  fontSize: 18,
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                _buildOptionTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  onTap: () {},
                ),
                  _buildOptionTile(
                  icon: Iconsax.notification,
                  title: 'Bookings',
                  onTap: () {
                    Get.toNamed(Routes.customerBookings);
                  },
                ),
                verticalSpaceMedium,

                // Support & About
                CustomText(
                  text: 'Support',
                  variant: TextVariant.bold,
                  fontSize: 18,
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                _buildOptionTile(
                  icon: Iconsax.message_question,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                _buildOptionTile(
                  icon: Iconsax.shield_tick,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                verticalSpaceLarge,

                // Account Actions
                const Divider(color: kcborderColor),
                verticalSpaceMedium,
                _buildActionTile(
                  icon: Iconsax.logout,
                  title: 'Logout',
                  color: kcTextGreyColor,
                  onTap: controller.logout,
                ),
                verticalSpaceSmall,
                _buildActionTile(
                  icon: Iconsax.trash,
                  title: 'Delete Account',
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kcPrimaryColor.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: kcPrimaryColor, size: 20),
            ),
            horizontalSpaceMedium,
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 14,
                variant: TextVariant.medium,
                color: kcBlackColor,
              ),
            ),
            const Icon(Iconsax.arrow_right_3, size: 16, color: kcTextGreyColor),
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
            Icon(icon, color: color, size: 20),
            horizontalSpaceSmall,
            CustomText(
              text: title,
              variant: TextVariant.bold,
              fontSize: 14,
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
              const CustomText(
                text: 'Delete Account?',
                variant: TextVariant.bold,
                fontSize: 18,
                color: kcBlackColor,
              ),
              verticalSpaceSmall,
              const CustomText(
                text:
                    'Are you sure you want to delete your account? This action cannot be undone.',
                fontSize: 14,
                color: kcTextGreyColor,
                textAlign: TextAlign.center,
              ),
              verticalSpaceLarge,
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      text: 'Cancel',
                      onPressed: () => Get.back(),
                    ),
                  ),
                  horizontalSpaceMedium,
                  Expanded(
                    child: CustomOutlineButton(
                      textColor: kcErrorColor,
                      text: 'Delete',
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
