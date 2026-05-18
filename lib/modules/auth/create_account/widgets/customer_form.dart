import 'package:karigar/export.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateAccountController>();
    return Form(
      key: controller.registerFormKey,
      child: Column(
        spacing: 12.h,
        children: [
          CustomTextField(
            controller: controller.fullNameController,
            hintText: AppStrings.fullNameHint,
            labelText: AppStrings.fullName,
            validator: AppValidators.name,
          ),
          CustomTextField(
            controller: controller.emailController,
            hintText: AppStrings.enterYourEmail,
            labelText: AppStrings.emailAdress,
            validator: AppValidators.email,
          ),
          GetBuilder<CreateAccountController>(
            id: "password",
            builder: (controller) {
              return CustomTextField(
                controller: controller.passwordController,
                hintText: AppStrings.passwordHint,
                labelText: AppStrings.password,
                validator: AppValidators.password,
                obscureText: controller.isObscure,
                suffixIcon: InkWell(
                  onTap: controller.togglePasswordVisibility,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                      size: 16,
                      controller.isObscure ? Iconsax.eye_slash : Iconsax.eye,
                    ),
                  ),
                ),
              );
            },
          ),
          verticalSpace(0),
          GetBuilder<CreateAccountController>(
            id: "form",
            builder: (controller) {
              return CustomButton(
                minSize: const Size(double.infinity, 51),
                maxSize: const Size(double.infinity, 51),
                width: double.infinity,
                text: controller.selectedValue == UserRole.serviceProvider
                    ? AppStrings.registerAsProvider
                    : AppStrings.createAccount,
                onPressed: () {
                  controller.submitSignUp();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
