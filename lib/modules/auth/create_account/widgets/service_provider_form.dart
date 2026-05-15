// import 'package:karigar/export.dart';

// class ServiceProviderForm extends StatelessWidget {
//   const ServiceProviderForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CreateAccountController>();
//     return Form(
//       key: controller.providerFormKey,
//       child: Column(
//         children: [
//           CustomTextField(
//             controller: controller.fullNameController,
//             hintText: AppStrings.fullNameHint,
//             labelText: AppStrings.fullName,
//             validator: AppValidators.name,
//           ),
//           verticalSpace(20),
//           CustomTextField(
//             controller: controller.emailController,
//             hintText: AppStrings.enterYourEmail,
//             labelText: AppStrings.emailAdress,
//             validator: AppValidators.email,
//           ),
//           verticalSpace(20),
//           GetBuilder<CreateAccountController>(
//             id: "password",
//             builder: (controller) {
//               return CustomTextField(
//                 controller: controller.passwordController,
//                 hintText: AppStrings.passwordHint,
//                 labelText: AppStrings.password,
//                 validator: AppValidators.password,
//                 obscureText: controller.isObscure,
//                 suffixIcon: InkWell(
//                   onTap: controller.togglePasswordVisibility,
//                   child: Icon(
//                     controller.isObscure ? Iconsax.eye_slash : Iconsax.eye,
//                   ),
//                 ),
//               );
//             },
//           ),

//           verticalSpace(40),
//           CustomButton(
//             minSize: const Size(double.infinity, 51),
//             maxSize: const Size(double.infinity, 51),
//             width: double.infinity,
//             text: AppStrings.registerAsProvider,
//             onPressed: () {
//               controller.submitSignUp();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
