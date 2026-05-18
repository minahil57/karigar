import 'package:karigar/export.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return CustomLayout(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    final newLang = LocalizationService.isUrdu ? 'en' : 'ur';
                    LocalizationService.changeLocale(newLang);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.global, size: 16, color: kcPrimaryColor),
                        horizontalSpaceTiny,
                        CustomText(
                          text: LocalizationService.isUrdu ? 'English' : 'اردو',
                          fontSize: 12,
                          color: kcPrimaryColor,
                          variant: TextVariant.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace(10),
              SlideInDown(
                from: 40,
                duration: const Duration(milliseconds: 1000),
                child: CustomText(
                  text: AppStrings.findExpertsOrGetHired,
                  fontSize: 24,
                  color: kcTextBlackcolor,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(20),
              SlideInDown(
                from: 40,
                duration: const Duration(milliseconds: 1000),
                child: CustomText(
                  text: AppStrings.signInToYourAccount,
                  fontSize: 16,
                  color: kcTextGreyColor,
                ),
              ),
              verticalSpace(50),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: AppStrings.enterYourEmail,
                      labelText: AppStrings.emailAdress,
                      validator: AppValidators.email,
                    ),
                    verticalSpace(20),
                    GetBuilder<LoginController>(
                      id: "password",
                      builder: (context) {
                        return CustomTextField(
                          controller: controller.passwordController,
                          hintText: AppStrings.passwordHint,
                          labelText: AppStrings.password,
                          validator: AppValidators.password,
                          obscureText: controller.isObscure,
                          suffixIcon: InkWell(
                            onTap: controller.togglePasswordVisibility,
                            child: Icon(
                              controller.isObscure
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                            ),
                          ),
                        );
                      },
                    ),
                    verticalSpace(40),
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
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppStrings.dontHaveAnAccount,
                    fontSize: 14,
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
