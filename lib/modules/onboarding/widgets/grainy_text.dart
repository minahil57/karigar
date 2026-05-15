import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:karigar/core/theme/app_colors.dart';

class SmoothGrainyText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration wordDelay;
  final Duration wordDuration;
  final List<int> brownIndexes;

  const SmoothGrainyText({
    super.key,
    required this.text,
    required this.style,
    this.wordDelay = const Duration(milliseconds: 400),
    this.wordDuration = const Duration(milliseconds: 800),
    this.brownIndexes = const [],
  });

  @override
  State<SmoothGrainyText> createState() => SmoothGrainyTextState();
}

class SmoothGrainyTextState extends State<SmoothGrainyText>
    with TickerProviderStateMixin {
  late List<String> words;
  late List<AnimationController> controllers;
  late List<Animation<double>> fades;
  late List<Animation<double>> blurs;
  bool reversePhase = false;

  @override
  void initState() {
    super.initState();
    _initAnimations(widget.text);
  }

  void _initAnimations(String text) {
    words = text.split(' ');

    controllers = List.generate(
      words.length,
      (_) => AnimationController(vsync: this, duration: widget.wordDuration),
    );

    fades = controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeInOut))
        .toList();

    blurs = controllers
        .map(
          (c) => Tween<double>(
            begin: 10,
            end: 0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic)),
        )
        .toList();

    _startForward();
  }

  Future<void> _startForward() async {
    for (int i = 0; i < words.length; i++) {
      await Future.delayed(widget.wordDelay);
      if (mounted) controllers[i].forward();
    }
  }

  @override
  void didUpdateWidget(covariant SmoothGrainyText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      for (var c in controllers) {
        c.dispose();
      }
      _initAnimations(widget.text);
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 12,
      children: List.generate(words.length, (i) {
        final isBrown = widget.brownIndexes.contains(i);
        final textStyle = isBrown
            ? widget.style.copyWith(color: kcSecondaryColor)
            : widget.style;

        return AnimatedBuilder(
          animation: controllers[i],
          builder: (context, _) {
            return Opacity(
              opacity: fades[i].value,
              child: Transform.translate(
                offset: Offset(
                  reversePhase
                      ? (20 * (1 - fades[i].value))
                      : (20 * (1 - fades[i].value)) * -1,
                  0,
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: blurs[i].value,
                    sigmaY: blurs[i].value,
                  ),
                  child: Text(
                    words[i],
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
