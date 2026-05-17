import 'dart:ui';

import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:karigar/export.dart';

/// A single chat bubble — used for [ChatMessageType.user] and [ChatMessageType.agentResponse].
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  bool get _isUser => message.type == ChatMessageType.user;
  bool get _isError => message.type == ChatMessageType.error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: _isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Flexible(child: _bubble())],
      ),
    );
  }

  Widget _bubble() {
    final bubbleRadius = BorderRadius.only(
      topLeft: Radius.circular(18.r),
      topRight: Radius.circular(18.r),
      bottomLeft: Radius.circular((_isUser ? 18 : 4).r),
      bottomRight: Radius.circular((_isUser ? 4 : 18).r),
    );

    return ClipRRect(
      borderRadius: bubbleRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: (_isUser ? 6 : 16).h,
          ),
          decoration: BoxDecoration(
            color: _isUser
                ? kcSecondaryColor.withValues(alpha: 0.2)
                : _isError
                ? kcErrorColor.withValues(alpha: 0.1)
                : kcWhitecolor.withValues(alpha: 0.4),
            borderRadius: bubbleRadius,
            border: Border.all(
              color: _isUser
                  ? kcSecondaryColor.withValues(alpha: 0.4)
                  : _isError
                  ? kcErrorColor.withValues(alpha: 0.3)
                  : kcWhitecolor.withValues(alpha: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: kcBlackColor.withValues(alpha: 0.06),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: !_isUser
              ? GptMarkdown(
                  _isError
                      ? "Something went wrong. Try again"
                      : message.text ?? '',
                  style: getMediumStyle(
                    fontSize: 13.sp,
                    color: kcTextBlackcolor,
                  ),
                )
              : CustomText(
                  text: message.text ?? '',
                  fontSize: 13,
                  variant: TextVariant.medium,
                  color: _isError ? kcErrorColor : kcTextBlackcolor,
                ),
        ),
      ),
    );
  }
}
