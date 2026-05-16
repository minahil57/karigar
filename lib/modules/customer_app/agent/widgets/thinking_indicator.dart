import 'package:karigar/export.dart';

/// Animated three-dot loading indicator shown while [AgentController.isThinking].
class ThinkingIndicator extends StatefulWidget {
  const ThinkingIndicator({super.key});

  @override
  State<ThinkingIndicator> createState() => _ThinkingIndicatorState();
}

class _ThinkingIndicatorState extends State<ThinkingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kcSecondaryColor,
            ),
            child: const Icon(Iconsax.cpu, size: 16, color: Colors.black),
          ),
          horizontalSpace(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: kcBlackColor.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => _Dot(index: i, controller: _ctrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.index, required this.controller});

  final int index;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final offset = index * 0.2;
    final animation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(offset, offset + 0.5, curve: Curves.easeInOut),
          ),
        );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: kcSecondaryColor.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
