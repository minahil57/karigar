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
            children: [
              SlideInDown(
                from: 40,
                duration: const Duration(milliseconds: 1000),
                child: CustomText(
                  text: AppStrings.findExpertsOrGetHired,
                  fontSize: 28,
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
              GetBuilder<CreateAccountController>(
                id: "tab",
                builder: (context) {
                  return CustomSegmentedTab(
                    items: UserRole.values.map((e) => e.title).toList(),
                    selectedValue: controller.selectedValue?.title ?? '',
                    onChanged: (value) {
                      final role = UserRole.values.firstWhere(
                        (e) => e.title == value,
                      );

                      controller.onChanged(role);
                    },
                  );
                },
              ),
              verticalSpace(20),
              CreateAccountForm(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Already Have an Account? ',
                    fontSize: 16,
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
