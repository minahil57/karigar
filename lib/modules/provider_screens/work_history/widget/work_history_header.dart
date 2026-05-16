import 'package:karigar/export.dart';

class WorkHistoryHeader extends StatelessWidget {
  const WorkHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kcWhitecolor,
                shape: BoxShape.circle,
                border: Border.all(color: kcborderColor),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: kcBlackColor,
              ),
            ),
          ),
          const CustomText(
            text: 'Work History',
            variant: TextVariant.bold,
            fontSize: 16,
            color: kcBlackColor,
          ),
          GestureDetector(
            onTap: () {
              // TODO: Implement Filter
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kcWhitecolor,
                shape: BoxShape.circle,
                border: Border.all(color: kcborderColor),
              ),
              child: const Icon(Iconsax.filter, size: 16, color: kcBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
