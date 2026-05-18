import 'dart:ui';

import 'package:karigar/export.dart';
import 'package:shimmer/shimmer.dart';

/// Renders an [agent:step] event as a status card with icon + animated indicator.
class StepCard extends StatelessWidget {
  const StepCard({super.key, required this.step});

  final AgentStep step;

  bool get isDone => step.status == 'done';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: kcWhitecolor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: kcWhitecolor.withValues(alpha: 0.5)),
              ),
              child: Row(
                spacing: 16.w,
                children: [
                  SizedBox(
                    height: 10.h,
                    width: 10.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: kcSecondaryColor,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: kcBlackColor,
                    highlightColor: kcBlackColor.withValues(alpha: 0.1),
                    child: CustomText(
                      text: _agentLabel(),
                      fontSize: 11,
                      color: kcTextGreyColor,
                      variant: TextVariant.medium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _agentLabel() {
    const labels = {
      'filter_extraction': 'Understanding Request',
      'provider_query': 'Searching Providers',
      'ranking': 'Ranking Results',
      'booking': 'Creating Booking',
      'follow_up': 'Scheduling Reminder',
    };
    return labels[step.agent] ?? step.agent;
  }
}
