import 'package:karigar/export.dart';

class WorkHistoryCard extends StatelessWidget {
  final ServiceRequestModel history;

  const WorkHistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final bookingStatus = BookingStatus.fromApi(history.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: history.providerService.service.name,
                      variant: TextVariant.bold,
                      fontSize: 14,
                      color: kcBlackColor,
                    ),
                    const CustomText(
                      text: 'Market Competitive',
                      variant: TextVariant.bold,
                      fontSize: 14,
                      color: kcBlackColor,
                    ),
                  ],
                ),
                verticalSpaceTiny,
                const CustomText(
                  text: 'Scheduled Service Booking',
                  fontSize: 11,
                  color: kcTextGreyColor,
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    const Icon(Iconsax.location, size: 12, color: kcTextLightGrey),
                    horizontalSpaceTiny,
                    CustomText(
                      text: history.location,
                      fontSize: 10,
                      color: kcTextLightGrey,
                    ),
                  ],
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    const Icon(Iconsax.calendar, size: 12, color: kcTextLightGrey),
                    horizontalSpaceTiny,
                    CustomText(
                      text: history.scheduledTime,
                      fontSize: 10,
                      color: kcTextLightGrey,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bookingStatus.backgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomText(
                  text: bookingStatus.title,
                  fontSize: 9,
                  color: bookingStatus.color,
                  variant: TextVariant.medium,
                ),
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  const Icon(Iconsax.star1, color: Colors.amber, size: 12),
                  horizontalSpaceTiny,
                  const CustomText(
                    text: '5.0',
                    fontSize: 10,
                    color: kcTextGreyColor,
                    variant: TextVariant.medium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
