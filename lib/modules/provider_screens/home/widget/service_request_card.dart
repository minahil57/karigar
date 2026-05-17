import 'package:karigar/export.dart';

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ServiceRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: request.providerService.service.name,
                            variant: TextVariant.bold,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 14,
                              max: 16,
                            ),
                            color: kcBlackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kcSecondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.magic_star,
                                color: kcSecondaryColor,
                                size: getResponsiveFontSize(
                                  context,
                                  fontSize: 12,
                                  max: 14,
                                ),
                              ),
                              horizontalSpaceTiny,
                              CustomText(
                                text: AppStrings.aiPerfectMatch,
                                variant: TextVariant.medium,
                                fontSize: getResponsiveFontSize(
                                  context,
                                  fontSize: 10,
                                  max: 12,
                                ),
                                color: kcSecondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: request.providerService.service.name,
                      color: kcTextGreyColor,
                      fontSize: getResponsiveFontSize(
                        context,
                        fontSize: 11,
                        max: 13,
                      ),
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: 12,
                          color: kcTextLightGrey,
                        ),
                        horizontalSpaceTiny,
                        CustomText(
                          text: request.location,
                          color: kcTextLightGrey,
                          fontSize: getResponsiveFontSize(
                            context,
                            fontSize: 10,
                            max: 12,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: kcPrimaryVeryLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: request.location,
                            variant: TextVariant.medium,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 9,
                              max: 11,
                            ),
                            color: kcPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: request.providerService.service.name,
                    variant: TextVariant.bold,
                    fontSize: getResponsiveFontSize(
                      context,
                      fontSize: 16,
                      max: 20,
                    ),
                    color: kcBlackColor,
                  ),
                  const CustomText(
                    text: AppStrings.estEarnings,
                    color: kcTextLightGrey,
                    fontSize: 9,
                  ),
                ],
              ),
            ],
          ),
          verticalSpaceSmall,
          Divider(color: kcborderColor.withValues(alpha: 0.3)),
          verticalSpaceSmall,
          Row(
            children: [
              const Icon(Iconsax.clock, size: 14, color: kcTextLightGrey),
              horizontalSpaceTiny,
              CustomText(
                text: request.createdAt,
                color: kcTextLightGrey,
                fontSize: getResponsiveFontSize(context, fontSize: 10, max: 12),
              ),
              const Spacer(),
              const Icon(Iconsax.calendar_1, size: 12, color: kcTextLightGrey),
              horizontalSpaceTiny,
              CustomText(
                text: '${AppStrings.preferred} ${request.scheduledTime}',
                variant: TextVariant.medium,
                color: kcDarkTextColor,
                fontSize: getResponsiveFontSize(context, fontSize: 10, max: 12),
              ),
            ],
          ),
          verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onAccept,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kcPrimaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: AppStrings.accept,
                            variant: TextVariant.medium,
                            color: kcWhitecolor,
                            fontSize: 12,
                          ),
                          horizontalSpaceTiny,
                          const Icon(
                            Icons.check,
                            color: kcWhitecolor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: GestureDetector(
                  onTap: onReject,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kcWhitecolor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: kcborderColor),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: AppStrings.reject,
                            variant: TextVariant.medium,
                            color: kcDarkTextColor,
                            fontSize: 12,
                          ),
                          horizontalSpaceTiny,
                          const Icon(
                            Icons.close,
                            color: kcDarkTextColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
