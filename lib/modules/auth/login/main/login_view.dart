import 'package:karigar/export.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                spacing: 20.h,
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
                  CustomAssetsImage(
                    imagePath: 'assets/images/logo.png',
                    height: 120.h,
                    width: 120.h,
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
                  Form(
                    key: controller.formKey,
                    child: Column(
                      spacing: 12.h,
                      children: [
                        CustomTextField(
                          controller: controller.emailController,
                          hintText: AppStrings.enterYourEmail,
                          labelText: AppStrings.emailAdress,
                          validator: AppValidators.email,
                        ),
                        Obx(
                          () => CustomTextField(
                            controller: controller.passwordController,
                            hintText: AppStrings.passwordHint,
                            labelText: AppStrings.password,
                            validator: AppValidators.password,
                            obscureText: controller.isObscure.value,
                            suffixIcon: InkWell(
                              onTap: controller.togglePasswordVisibility,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Icon(
                                  size: 16,
                                  controller.isObscure.value
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(5),
                        CustomButton(
                          minSize: Size(double.infinity, 51),
                          maxSize: Size(double.infinity, 51),
                          width: double.infinity,
                          text: AppStrings.signIn,

                          onPressed: () {
                            controller.submitLogin();
                            //  Get.toNamed(Routes.home);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppStrings.dontHaveAnAccount,
                    fontSize: 12,
                    color: kcTextGreyColor,
                  ),
                  CustomTextButton(
                    text: AppStrings.createAccount,
                    onPressed: () {
                      Get.offNamed(Routes.createAccount);
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
