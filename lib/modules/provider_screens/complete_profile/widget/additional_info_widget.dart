import 'package:karigar/export.dart';

class AdditionalInfoWidget extends StatelessWidget {
  const AdditionalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: kcPrimaryColor, // Primary Accent
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                horizontalSpace(10),
                const CustomText(
                  text: 'Additional Information',
                  fontSize: 16,
                  variant: TextVariant.bold,
                  color: kcBlackColor,
                ),
              ],
            ),
            verticalSpace(15),
            CustomTextField(
              controller: controller.aboutMeController,
              labelText: 'About Me',
              hintText: 'Tell us about yourself...',
              prefixIcon: const Icon(Icons.notes, color: kcPrimaryColor, size: 20),
            ),
          ],
        );
      },
    );
  }
}
