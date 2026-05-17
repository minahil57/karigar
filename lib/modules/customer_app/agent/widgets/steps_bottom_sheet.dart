import 'package:karigar/export.dart';

class StepsBottomSheet extends StatelessWidget {
  final List<AgentStep> steps;

  const StepsBottomSheet({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Process Details',
                fontSize: 18,
                variant: TextVariant.medium,
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          verticalSpace(10),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: steps.length,
              separatorBuilder: (context, index) => verticalSpace(12),
              itemBuilder: (context, index) {
                final step = steps[index];
                return _StepTile(step: step);
              },
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final AgentStep step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    final bool isDone = step.status == 'done';
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone ? const Color(0xFF22C55E) : kcSecondaryColor.withValues(alpha: 0.1),
          ),
          child: Icon(
            isDone ? Icons.check : Icons.more_horiz,
            size: 14,
            color: isDone ? Colors.white : kcSecondaryColor,
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: _getLabel(step.agent),
                fontSize: 14,
                variant: TextVariant.medium,
                color: kcTextBlackcolor,
              ),
              CustomText(
                text: step.message,
                fontSize: 12,
                color: kcTextGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getLabel(String agent) {
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
