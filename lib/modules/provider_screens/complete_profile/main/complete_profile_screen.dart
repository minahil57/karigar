import 'package:karigar/export.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: kcWhitecolor,
          appBar: AppBar(
            
            title: const CustomText(
              text: 'Complete Profile',
              fontSize: 18,
              variant: TextVariant.bold,
              color: kcBlackColor,
            ),
            backgroundColor: kcWhitecolor,
            elevation: 0,
            iconTheme: const IconThemeData(color: kcBlackColor),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PersonalInfoWidget(),
                  verticalSpace(25),
                  const ServiceDetailsWidget(),
                  verticalSpace(25),
                  const AdditionalInfoWidget(),
                  verticalSpace(40),
                  CustomButton(
                    text: 'Save Profile',
                    onPressed: () => controller.submitData(),
                    width: double.infinity,
                    isEnabled: controller.isFormFilled,
                    isLoading: controller.isSubmitting,
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
