import 'dart:ui';

import 'package:karigar/export.dart';
import 'package:karigar/modules/customer_app/agent/widgets/steps_bottom_sheet.dart';

/// Interactive glassmorphic trigger button that opens the [StepsBottomSheet]
/// displaying detailed execution steps and thought reflections taken by the AI agent.
class StepsTrigger extends StatelessWidget {
  const StepsTrigger({super.key, required this.items});

  final List<ChatMessage> items;

  int get _stepsCount =>
      items.where((m) => m.type == ChatMessageType.agentStep).length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kcWhitecolor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: kcWhitecolor.withValues(alpha: 0.5)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      StepsBottomSheet(items: items),
                      isScrollControlled: true,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12.w,
                      children: [
                        Icon(
                          Iconsax.hierarchy,
                          size: 14,
                          color: kcSecondaryColor,
                        ),
                        CustomText(
                          text: 'Thoughts ($_stepsCount steps)',
                          fontSize: 11,
                          color: kcSecondaryColor,
                          variant: TextVariant.medium,
                        ),
                        Icon(
                          Iconsax.arrow_right_1,
                          size: 14,
                          color: kcSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
