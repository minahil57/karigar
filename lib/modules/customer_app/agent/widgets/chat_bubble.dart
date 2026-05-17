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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: _isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!_isUser) _agentAvatar(),
          if (!_isUser) horizontalSpace(8),
          Flexible(child: _bubble()),
        ],
      ),
    );
  }

  Widget _agentAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isError ? kcErrorColor : kcSecondaryColor,
      ),
      child: Icon(
        _isError ? Iconsax.warning_2 : Iconsax.bubble,
        size: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _bubble() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: _isUser ? 6 : 16),
      decoration: BoxDecoration(
        color: _isUser
            ? kcSecondaryColor
            : _isError
            ? kcErrorColor.withValues(alpha: 0.1)
            : kcWhitecolor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(_isUser ? 18 : 4),
          bottomRight: Radius.circular(_isUser ? 4 : 18),
        ),
        boxShadow: [
          BoxShadow(
            color: kcBlackColor.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: !_isUser
          ? GptMarkdown(message.text ?? '')
          : CustomText(
              text: message.text ?? '',
              fontSize: 14,
              color: _isError ? kcErrorColor : kcTextBlackcolor,
            ),
    );
  }
}
