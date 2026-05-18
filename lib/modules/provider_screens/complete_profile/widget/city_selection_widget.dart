import 'package:karigar/export.dart';

class CitySelectionWidget extends StatelessWidget {
  const CitySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
      builder: (controller) {
        if (controller.isLocationLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircularProgressIndicator(color: kcSecondaryColor), // Teal accent loading
                  verticalSpaceSmall,
                  CustomText(
                    text: 'Detecting your location...',
                    fontSize: 14,
                    variant: TextVariant.medium,
                    color: kcSecondaryColor,
                  ),
                ],
              ),
            ),
          );
        }

        // If city is unsupported
        if (!controller.isCitySupported) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
                    horizontalSpace(8),
                    const CustomText(
                      text: AppStrings.unsupportedLocation,
                      fontSize: 15,
                      variant: TextVariant.bold,
                      color: Colors.red,
                    ),
                  ],
                ),
                verticalSpace(10),
                CustomText(
                  text: 'We do not operate in your current city (${controller.detectedCity ?? "Unknown Location"}).',
                  fontSize: 13,
                  variant: TextVariant.regular,
                  color: Colors.red,
                ),
                verticalSpace(5),
                const CustomText(
                  text: 'We currently operate in Islamabad, Rawalpindi, Karachi, and Lahore.',
                  fontSize: 13,
                  variant: TextVariant.medium,
                  color: kcBlackColor,
                ),
                verticalSpace(15),
                const CustomText(
                  text: 'Please select a supported city to continue:',
                  fontSize: 13,
                  variant: TextVariant.bold,
                  color: kcBlackColor,
                ),
                verticalSpace(8),
                _buildCityDropdown(controller),
              ],
            ),
          );
        }

        // If city is supported
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: kcPrimaryColor, size: 20), // Primary focus
                    horizontalSpace(6),
                    CustomText(
                      text: 'City: ${controller.activeCity}',
                      fontSize: 14,
                      variant: TextVariant.bold,
                      color: kcBlackColor,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    _showChangeCityBottomSheet(context, controller);
                  },
                  child: const CustomText(
                    text: AppStrings.changeCity,
                    fontSize: 13,
                    variant: TextVariant.medium,
                    color: kcSecondaryColor, // Accent touch
                  ),
                ),
              ],
            ),
            verticalSpace(8),
            
            // Areas chips list: Active chips use Teal as selection accent
            if (controller.availableAreas.isEmpty)
              const CustomText(
                text: 'No areas available for this city.',
                fontSize: 13,
                variant: TextVariant.regular,
                color: Colors.grey,
              )
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.availableAreas.map((area) {
                  final isSelected = controller.selectedAreas.contains(area);
                  return FilterChip(
                    label: CustomText(
                      text: area,
                      color: isSelected ? kcWhitecolor : kcBlackColor,
                      fontSize: 13,
                      variant: TextVariant.regular,
                    ),
                    selected: isSelected,
                    selectedColor: kcSecondaryColor, // Teal selected accent
                    backgroundColor: kcPrimaryVeryLight, // Light gray base
                    checkmarkColor: kcWhitecolor,
                    onSelected: (bool selected) {
                      controller.toggleArea(area, selected);
                    },
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCityDropdown(CompleteProfileController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kcborderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedCityOverride,
          dropdownColor: kcWhitecolor,
          hint: const CustomText(
            text: AppStrings.chooseSupportedCity,
            fontSize: 14,
            color: Colors.grey,
            variant: TextVariant.regular,
          ),
          icon: const Icon(Icons.arrow_drop_down, color: kcBlackColor),
          isExpanded: true,
          onChanged: (String? value) {
            controller.setCityOverride(value);
          },
          items: controller.supportedCities.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CustomText(
                text: value,
                fontSize: 14,
                variant: TextVariant.medium,
                color: kcBlackColor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showChangeCityBottomSheet(BuildContext context, CompleteProfileController controller) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: AppStrings.selectOperatingCity,
              fontSize: 18,
              variant: TextVariant.bold,
              color: kcBlackColor,
            ),
            verticalSpace(15),
            ListView(
              shrinkWrap: true,
              children: controller.supportedCities.map((city) {
                final isSelected = controller.activeCity == city;
                return ListTile(
                  title: CustomText(
                    text: city,
                    fontSize: 16,
                    variant: isSelected ? TextVariant.bold : TextVariant.medium,
                    color: isSelected ? kcSecondaryColor : kcBlackColor,
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: kcSecondaryColor) : null,
                  onTap: () {
                    controller.setCityOverride(city);
                    Get.back();
                  },
                );
              }).toList(),
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
