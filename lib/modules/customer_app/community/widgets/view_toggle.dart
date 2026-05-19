import 'package:karigar/export.dart';

class ViewToggleButton extends StatefulWidget {
  const ViewToggleButton({super.key});

  @override
  State<ViewToggleButton> createState() => _ViewToggleButtonState();
}

class _ViewToggleButtonState extends State<ViewToggleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconAnim;
  static bool _hasShownTooltip = false;
  bool _showTooltip = false;

  @override
  void initState() {
    super.initState();
    final ctrl = Get.find<CommunityController>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: ctrl.isMapView ? 1.0 : 0.0,
    );
    _iconAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (!_hasShownTooltip) {
      _showTooltip = true;
      _hasShownTooltip = true;
      Future.delayed(const Duration(seconds: 6), () {
        if (mounted) {
          setState(() => _showTooltip = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(CommunityController ctrl) {
    final goingToMap = !ctrl.isMapView;
    if (goingToMap) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    ctrl.setMapView(goingToMap);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      id: 'view-type',
      builder: (ctrl) {
        final targetValue = ctrl.isMapView ? 1.0 : 0.0;
        if (_controller.value != targetValue && !_controller.isAnimating) {
          if (ctrl.isMapView) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        }

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: [
            if (_showTooltip)
              Positioned(
                right: 60,
                child: FadeInRight(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _showTooltip = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3B5D),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: kcBlackColor.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                color: Colors.amber,
                                size: 14,
                              ),
                              horizontalSpaceTiny,
                              const CustomText(
                                text: 'Click here to switch view!',
                                fontSize: 11,
                                variant: TextVariant.medium,
                                color: kcWhitecolor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-4, 0),
                        child: Transform.rotate(
                          angle: 0.785398,
                          child: Container(
                            width: 8,
                            height: 8,
                            color: const Color(0xFF1A3B5D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                setState(() => _showTooltip = false);
                _handleTap(ctrl);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: kcSecondaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kcSecondaryColor.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _iconAnim,
                  builder: (context, _) {
                    final t = _iconAnim.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: (1 - t).clamp(0.0, 1.0),
                          child: Transform.scale(
                            scale: 1 - (t * 0.5),
                            child: Transform.rotate(
                              angle: t * 1.5,
                              child: const Icon(
                                Iconsax.map,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: t.clamp(0.0, 1.0),
                          child: Transform.scale(
                            scale: 0.5 + (t * 0.5),
                            child: Transform.rotate(
                              angle: (1 - t) * -1.5,
                              child: const Icon(
                                Iconsax.location,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
