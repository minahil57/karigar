import 'package:karigar/export.dart';
import '../model/work_history_model.dart';

class WorkHistoryCard extends StatelessWidget {
  final WorkHistoryModel history;

  const WorkHistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
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
                      text: history.serviceTitle,
                      variant: TextVariant.bold,
                      fontSize: 14,
                      color: kcBlackColor,
                    ),
                    CustomText(
                      text: history.price,
                      variant: TextVariant.bold,
                      fontSize: 14,
                      color: kcBlackColor,
                    ),
                  ],
                ),
                verticalSpaceTiny,
                CustomText(
                  text: history.description,
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
                      text: history.dateTime,
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
                  color: history.status == WorkStatus.completed
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomText(
                  text: history.status == WorkStatus.completed ? 'Completed' : 'Cancelled',
                  fontSize: 9,
                  color: history.status == WorkStatus.completed ? Colors.green : Colors.red,
                  variant: TextVariant.medium,
                ),
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  const Icon(Iconsax.star1, color: Colors.amber, size: 12),
                  horizontalSpaceTiny,
                  CustomText(
                    text: history.rating.toString(),
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
