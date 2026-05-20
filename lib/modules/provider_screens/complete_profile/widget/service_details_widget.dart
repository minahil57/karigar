import 'package:karigar/export.dart';

class ServiceDetailsWidget extends StatelessWidget {
  const ServiceDetailsWidget({super.key});

  void _showLanguageSelectionBottomSheet(
    BuildContext context,
    CompleteProfileController controller,
  ) {
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
            CustomText(
              text: AppStrings.selectLanguages,
              fontSize: 18,
              variant: TextVariant.bold,
              color: kcBlackColor,
            ),
            verticalSpace(15),
            Flexible(
              child: GetBuilder<CompleteProfileController>(
                builder: (ctrl) {
                  return ListView(
                    shrinkWrap: true,
                    children: ctrl.availableLanguages.map((lang) {
                      final isSelected = ctrl.selectedLanguages.contains(lang);
                      return CheckboxListTile(
                        title: CustomText(
                          text: lang.tr,
                          fontSize: 16,
                          variant: TextVariant.medium,
                          color: kcBlackColor,
                        ),
                        value: isSelected,
                        activeColor: kcSecondaryColor,
                        onChanged: (bool? val) {
                          ctrl.toggleLanguage(lang, val ?? false);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
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
                CustomText(
                  text: AppStrings.serviceDetails,
                  fontSize: 16,
                  variant: TextVariant.bold,
                  color: kcBlackColor,
                ),
              ],
            ),
            verticalSpace(15),

            CustomText(
              text: AppStrings.selectService,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),
            if (controller.isLoadingServices)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(color: kcSecondaryColor),
                ),
              )
            else if (controller.services.isEmpty)
              CustomText(
                text: AppStrings.noServicesAvailable,
                fontSize: 12,
                variant: TextVariant.regular,
                color: Colors.grey,
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: kcWhitecolor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kcborderColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ServiceModel>(
                    value: controller.selectedService,
                    dropdownColor: kcWhitecolor,
                    hint: CustomText(
                      text: AppStrings.selectServiceHint,
                      fontSize: 12,
                      color: Colors.grey,
                      variant: TextVariant.regular,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: kcBlackColor,
                    ),
                    isExpanded: true,
                    onChanged: controller.setSelectedService,
                    items: controller.services.map((service) {
                      return DropdownMenuItem<ServiceModel>(
                        value: service,
                        child: CustomText(
                          text: service.name,
                          fontSize: 14,
                          variant: TextVariant.medium,
                          color: kcBlackColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            verticalSpace(15),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.servicePriceController,
                    labelText: AppStrings.servicePrice,
                    hintText: '1500',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.payments_outlined,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  child: CustomTextField(
                    controller: controller.serviceDurationController,
                    labelText: AppStrings.serviceDuration,
                    hintText: '60',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.timer_outlined,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(20),

            // Service Cities
            CustomText(
              text: AppStrings.serviceAreasLabel,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),
            const CitySelectionWidget(),
            verticalSpace(20),

            // Multi-select Languages Dropdown
            CustomText(
              text: AppStrings.languagesSpoken,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),
            GestureDetector(
              onTap: () =>
                  _showLanguageSelectionBottomSheet(context, controller),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: kcWhitecolor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: kcborderColor.withValues(alpha: 0.8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.language_outlined,
                          color: kcPrimaryColor,
                          size: 20,
                        ),
                        horizontalSpace(10),
                        controller.selectedLanguages.isEmpty
                            ? CustomText(
                                text: AppStrings.selectLanguagesHint,
                                fontSize: 12,
                                color: Colors.grey,
                                variant: TextVariant.regular,
                              )
                            : CustomText(
                                text: controller.selectedLanguages
                                    .map((e) => e.tr)
                                    .join(', '),
                                fontSize: 14,
                                color: kcBlackColor,
                                variant: TextVariant.medium,
                              ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, color: kcBlackColor),
                  ],
                ),
              ),
            ),
            verticalSpace(20),

            // Upwork-style Skills Search/Add Field
            CustomText(
              text: AppStrings.skillsExpertise,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(15),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.skillInputController,
                    labelText: AppStrings.addSkill,
                    hintText: AppStrings.addSkillHint,
                    prefixIcon: const Icon(
                      Icons.star_outline,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                  ),
                ),
                horizontalSpace(10),
                GestureDetector(
                  onTap: () {
                    controller.addSkill(controller.skillInputController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: kcWhitecolor),
                  ),
                ),
              ],
            ),
            verticalSpace(10),

            // Upwork style chips using Teal Palette as secondary accent (30%)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.selectedSkills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kcSecondaryLightColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kcSecondaryColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: skill,
                        fontSize: 13,
                        variant: TextVariant.medium,
                        color: kcSecondaryColor,
                      ),
                      horizontalSpace(6),
                      GestureDetector(
                        onTap: () => controller.removeSkill(skill),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: kcSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            verticalSpace(20),

            // Availability Option
            CustomText(
              text: AppStrings.availabilityOption,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.availabilityOptions.map((opt) {
                final isSelected = controller.selectedAvailability == opt;
                return ChoiceChip(
                  label: CustomText(
                    text: opt.tr,
                    color: isSelected ? kcWhitecolor : kcBlackColor,
                    fontSize: 12,
                    variant: TextVariant.regular,
                  ),
                  selected: isSelected,
                  selectedColor: kcSecondaryColor,
                  backgroundColor: kcPrimaryVeryLight,
                  checkmarkColor: kcWhitecolor,
                  onSelected: (bool selected) {
                    if (selected) {
                      controller.setAvailability(opt);
                    }
                  },
                );
              }).toList(),
            ),
            verticalSpace(15),

            // Dynamic User custom time pickers
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.openingTime,
                        fontSize: 12,
                        variant: TextVariant.medium,
                        color: kcBlackColor,
                      ),
                      verticalSpace(8),
                      GestureDetector(
                        onTap: () => controller.pickStartTime(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: kcWhitecolor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kcborderColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: controller.formatTimeForUi(
                                  controller.selectedStartTime,
                                  context,
                                ),
                                fontSize: 12,
                                variant: TextVariant.medium,
                                color: kcBlackColor,
                              ),
                              const Icon(
                                Icons.access_time,
                                color: kcSecondaryColor,
                                size: 16,
                              ), // Secondary teal theme accent
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.closingTime,
                        fontSize: 12,
                        variant: TextVariant.medium,
                        color: kcBlackColor,
                      ),
                      verticalSpace(8),
                      GestureDetector(
                        onTap: () => controller.pickEndTime(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: kcWhitecolor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kcborderColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: controller.formatTimeForUi(
                                  controller.selectedEndTime,
                                  context,
                                ),
                                fontSize: 12,
                                variant: TextVariant.medium,
                                color: kcBlackColor,
                              ),
                              const Icon(
                                Icons.access_time,
                                color: kcSecondaryColor,
                                size: 16,
                              ), // Secondary teal theme accent
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(20),

            // Price Range Dropdown/Chips
            CustomText(
              text: AppStrings.priceRange,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.priceRangeOptions.map((range) {
                final isSelected = controller.selectedPriceRange == range;
                return ChoiceChip(
                  label: CustomText(
                    text: range.tr.toUpperCase(),
                    color: isSelected ? kcWhitecolor : kcBlackColor,
                    fontSize: 13,
                    variant: TextVariant.regular,
                  ),
                  selected: isSelected,
                  selectedColor: kcSecondaryColor,
                  backgroundColor: kcPrimaryVeryLight,
                  checkmarkColor: kcWhitecolor,
                  onSelected: (bool selected) {
                    if (selected) {
                      controller.setPriceRange(range);
                    }
                  },
                );
              }).toList(),
            ),
            verticalSpace(20),
            CustomText(
              text: AppStrings.experience,
              fontSize: 14,
              variant: TextVariant.medium,
              color: kcBlackColor,
            ),
            verticalSpace(8),

            CustomTextField(
              controller: controller.experienceController,
              labelText: AppStrings.experienceYearsLabel,
              hintText: AppStrings.experienceHint,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.trending_up,
                color: kcPrimaryColor,
                size: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
