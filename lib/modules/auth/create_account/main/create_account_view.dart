import 'package:karigar/export.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateAccountController>();
    return CustomLayout(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 30.h,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        final newLang = LocalizationService.isUrdu
                            ? 'en'
                            : 'ur';
                        LocalizationService.changeLocale(newLang);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kcPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: kcPrimaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Iconsax.global,
                              size: 16,
                              color: kcPrimaryColor,
                            ),
                            horizontalSpaceTiny,
                            CustomText(
                              text: LocalizationService.isUrdu
                                  ? 'English'
                                  : 'اردو',
                              fontSize: 12,
                              color: kcPrimaryColor,
                              variant: TextVariant.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SlideInDown(
                    from: 40,
                    duration: const Duration(milliseconds: 1000),
                    child: CustomText(
                      text: AppStrings.findExpertsOrGetHired,
                      fontSize: 18,
                      variant: TextVariant.medium,
                      color: kcTextBlackcolor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SlideInDown(
                    from: 40,
                    duration: const Duration(milliseconds: 1000),
                    child: CustomText(
                      text: AppStrings.signInToYourAccount,
                      fontSize: 16,
                      color: kcTextGreyColor,
                    ),
                  ),
                  verticalSpace(0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      spacing: 12.h,
                      children: [
                        GetBuilder<CreateAccountController>(
                          id: "tab",
                          builder: (context) {
                            return CustomSegmentedTab(
                              items: UserRole.values
                                  .map((e) => e.title)
                                  .toList(),
                              selectedValue:
                                  controller.selectedValue?.title ?? '',
                              onChanged: (value) {
                                final role = UserRole.values.firstWhere(
                                  (e) => e.title == value,
                                );

                                controller.onChanged(role);
                              },
                            );
                          },
                        ),
                        CreateAccountForm(),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppStrings.alreadyHaveAccount,
                    fontSize: 12,
                    color: kcTextGreyColor,
                  ),
                  CustomTextButton(
                    text: AppStrings.signIn,
                    onPressed: () {
                      Get.offNamed(Routes.login);
                    },
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
