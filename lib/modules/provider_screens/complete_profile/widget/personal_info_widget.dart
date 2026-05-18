import 'package:karigar/export.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({super.key});

  void _showImageSourceBottomSheet(BuildContext context, CompleteProfileController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: 'Select Profile Picture',
              fontSize: 18,
              variant: TextVariant.bold,
              color: kcBlackColor,
            ),
            verticalSpace(20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: kcSecondaryColor),
              title: const CustomText(text: 'Take Photo', fontSize: 16, variant: TextVariant.medium),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: kcSecondaryColor),
              title: const CustomText(text: 'Choose from Gallery', fontSize: 16, variant: TextVariant.medium),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }

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
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                horizontalSpace(10),
                const CustomText(
                  text: 'Personal Information',
                  fontSize: 16,
                  variant: TextVariant.bold,
                  color: kcBlackColor,
                ),
              ],
            ),
            verticalSpace(20),
            
            // 70-30 Image Picker: Primary circle, secondary accent edit badge
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => _showImageSourceBottomSheet(context, controller),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: kcPrimaryVeryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: kcPrimaryColor, width: 2),
                        image: controller.pickedImage != null
                            ? DecorationImage(
                                image: FileImage(File(controller.pickedImage!.path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: controller.pickedImage == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: kcPrimaryColor,
                                  size: 32,
                                ),
                                verticalSpaceSmall,
                                CustomText(
                                  text: 'Upload',
                                  fontSize: 12,
                                  variant: TextVariant.medium,
                                  color: kcPrimaryColor,
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _showImageSourceBottomSheet(context, controller),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: kcSecondaryColor, // Accent pop
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: kcWhitecolor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(25),
            
            CustomTextField(
              controller: controller.nameController,
              labelText: 'Business Name',
              hintText: 'Enter your business name',
              prefixIcon: const Icon(Icons.business_outlined, color: kcPrimaryColor, size: 20),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            verticalSpace(15),
            CustomTextField(
              controller: controller.professionController,
              labelText: 'Profession',
              hintText: 'e.g. Electrician, Plumber',
              prefixIcon: const Icon(Icons.work_outline, color: kcPrimaryColor, size: 20),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            verticalSpace(15),
            CustomTextField(
              controller: controller.phoneController,
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              maxLength: 11,
              prefixIcon: const Icon(Icons.phone_outlined, color: kcPrimaryColor, size: 20),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Required';
                if (val.length != 11) return 'Must be exactly 11 digits';
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
