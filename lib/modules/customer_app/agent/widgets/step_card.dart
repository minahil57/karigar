import 'package:karigar/export.dart';

/// Renders an [agent:step] event as a status card with icon + animated indicator.
class StepCard extends StatelessWidget {
  const StepCard({super.key, required this.step});

  final AgentStep step;

  bool get isDone => step.status == 'done';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: kcWhitecolor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDone
                ? const Color(0xFF22C55E).withValues(alpha: 0.4)
                : kcSecondaryColor.withValues(alpha: 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: kcBlackColor.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _stepIcon(),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: _agentLabel(),
                    fontSize: 11,
                    color: kcTextGreyColor,
                    variant: TextVariant.medium,
                  ),
                  verticalSpace(2),
                  CustomText(
                    text: step.message,
                    fontSize: 13,
                    color: kcTextBlackcolor,
                  ),
                ],
              ),
            ),
            horizontalSpace(12),
            _statusIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _stepIcon() {
    final icons = {
      'filter_extraction': Iconsax.search_normal,
      'provider_query': Iconsax.location,
      'ranking': Iconsax.star,
      'booking': Iconsax.calendar_tick,
      'follow_up': Iconsax.notification,
    };
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: kcSecondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icons[step.agent] ?? Iconsax.cpu,
        size: 18,
        color: kcSecondaryColor,
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

  Widget _statusIndicator() {
    if (isDone) {
      return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: const Color(0xFF22C55E),
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      );
    }
    return _PulsingDot();
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: kcSecondaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
