import 'package:karigar/export.dart';

/// Bottom sheet displaying the complete agent trace log, detailing
/// the chronological sequence of execution steps and internal reflections.
class StepsBottomSheet extends StatelessWidget {
  final List<ChatMessage> items;

  const StepsBottomSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: kcborderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Thoughts',
                      fontSize: 18,
                      variant: TextVariant.bold,
                      color: kcTextBlackcolor,
                    ),
                    verticalSpace(2),
                    CustomText(
                      text: 'Steps and thoughts of the agent',
                      fontSize: 11,
                      color: kcTextGreyColor,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          verticalSpace(10),

          // Timeline Content
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    final isLast = index == items.length - 1;
                    return _TimelineTile(item: item, isLast: isLast);
                  }),
                ),
              ),
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final ChatMessage item;
  final bool isLast;

  const _TimelineTile({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isStep = item.type == ChatMessageType.agentStep;
    final step = item.step;
    final isDone = isStep && step?.status == 'done';

    // Icon Configuration
    final IconData icon = isStep
        ? (isDone ? Iconsax.tick_circle : Iconsax.info_circle)
        : Iconsax.bubble;

    final Color iconColor = isStep
        ? (isDone ? const Color(0xFF22C55E) : kcSecondaryColor)
        : kcPrimaryColor;

    final Color iconBg = isStep
        ? (isDone
              ? const Color(0xFFE8FDF0)
              : kcSecondaryColor.withValues(alpha: 0.1))
        : kcPrimaryVeryLight;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Timeline Axis
          SizedBox(
            width: 32.w,
            child: Column(
              children: [
                // Icon Wrapper
                Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBg,
                  ),
                  child: Center(
                    child: Icon(icon, size: 14.r, color: iconColor),
                  ),
                ),
                // Connective line to next node
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5.w,
                      color: kcLightBorderColor.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),
          horizontalSpace(12),

          // Right Content Area
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: isStep ? _buildStepContent() : _buildThoughtContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    final step = item.step!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: _getStepLabel(step.agent),
          fontSize: 13,
          variant: TextVariant.medium,
          color: kcTextBlackcolor,
        ),
        verticalSpace(4),
        CustomText(text: step.message, fontSize: 12, color: kcTextGreyColor),
      ],
    );
  }

  Widget _buildThoughtContent() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: kcPrimaryVeryLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.message_programming,
                size: 12.r,
                color: kcPrimaryColor.withValues(alpha: 0.6),
              ),
              horizontalSpace(6),
              CustomText(
                text: 'Reflection',
                fontSize: 10,
                color: kcPrimaryColor.withValues(alpha: 0.6),
                variant: TextVariant.medium,
              ),
            ],
          ),
          verticalSpace(6),
          Text(
            item.text ?? '',
            style: getRegularStyle(fontSize: 13, color: kcDarkGreyTextColor),
          ),
        ],
      ),
    );
  }

  String _getStepLabel(String agent) {
    const labels = {
      'filter_extraction': 'Understanding Request',
      'provider_query': 'Searching Providers',
      'ranking': 'Ranking Results',
      'booking': 'Creating Booking',
      'follow_up': 'Scheduling Reminder',
    };
    return labels[agent] ?? agent;
  }
}
