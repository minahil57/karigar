import 'dart:ui';

import 'package:karigar/export.dart';

/// A custom expandable bubble showing the agent's inner thought process in real-time.
class ThoughtBubble extends StatefulWidget {
  const ThoughtBubble({super.key, required this.text});

  final String text;

  @override
  State<ThoughtBubble> createState() => _ThoughtBubbleState();
}

class _ThoughtBubbleState extends State<ThoughtBubble> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final bubbleRadius = BorderRadius.circular(16.r);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: ClipRRect(
        borderRadius: bubbleRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kcWhitecolor.withValues(alpha: 0.2),
                borderRadius: bubbleRadius,
                border: Border.all(color: kcWhitecolor.withValues(alpha: 0.5)),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                borderRadius: bubbleRadius,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.bubble,
                            size: 16.r,
                            color: kcTextGreyColor,
                          ),
                          horizontalSpace(8),
                          Expanded(
                            child: CustomText(
                              text: "Thought Process",
                              fontSize: 12,
                              color: kcTextGreyColor,
                              variant: TextVariant.medium,
                            ),
                          ),
                          Icon(
                            _isExpanded
                                ? Iconsax.arrow_up_1
                                : Iconsax.arrow_down_2,
                            size: 16.r,
                            color: kcTextGreyColor,
                          ),
                        ],
                      ),
                      if (_isExpanded) ...[
                        verticalSpace(8),
                        Text(
                          widget.text,
                          style: getRegularStyle(
                            fontSize: 11,
                            color: kcTextGreyColor,
                          ),
                        ),
                      ],
                    ],
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
