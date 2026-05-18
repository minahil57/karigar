import 'dart:math' as math;

import 'package:karigar/export.dart';

class CustomProgressButton extends StatelessWidget {
  final double progress;
  final Duration duration;
  final VoidCallback? ontap;

  const CustomProgressButton({
    super.key,
    required this.progress,
    this.ontap,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: duration,
        builder: (context, value, child) {
          return SizedBox(
            width: 45.h,
            height: 45.h,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                progress: value,
                strokeWidth: 8,
                backgroundColor: kcWhitecolor,
                progressColor: kcPrimaryColor,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: kcSecondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_rounded, color: kcPrimaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 20);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    paint.color = progressColor;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
