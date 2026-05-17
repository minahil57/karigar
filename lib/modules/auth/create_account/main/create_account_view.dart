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
                spacing: 20.h,
                children: [
                  CustomAssetsImage(
                    imagePath: 'assets/images/logo.png',
                    height: 100.h,
                    width: 100.h,
                    fit: BoxFit.cover,
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
                    text: 'Already Have an Account? ',
                    fontSize: 12,
                    color: kcTextGreyColor,
                  ),
                  CustomTextButton(
                    text: 'Sign In',
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
