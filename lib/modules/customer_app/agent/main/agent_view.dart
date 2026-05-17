import 'package:karigar/export.dart';
import 'package:karigar/modules/customer_app/agent/widgets/steps_trigger.dart';
import 'package:karigar/modules/customer_app/agent/widgets/thought_bubble.dart';

class AgentView extends StatelessWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgentController>();

    return CustomLayout(
      child: Stack(
        children: [
          // ── Background glow ─────────────────────────────────────────────
          Positioned(
            bottom: -150.h,
            right: -150.w,
            child: Container(
              width: context.width * (500 / 360),
              height: context.height * (500 / 690),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    kcSecondaryColor.withValues(alpha: 0.6),
                    kcSecondaryColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Chat area ─────────────────────────────────────────────────
                Expanded(
                  child: Obx(() {
                    final messages = controller.messages;
                    final hasMessages = messages.isNotEmpty;

                    if (!hasMessages) {
                      // ── Empty state: logo + greeting ──────────────────────
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              verticalSpace(40),
                              FadeInDown(
                                child: Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kcWhitecolor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kcBlackColor.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 40.r,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: CustomAssetsImage(
                                    imagePath: 'assets/images/logo.png',
                                    height: 80.h,
                                    width: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              verticalSpace(20),
                              FadeInUp(
                                child: CustomText(
                                  text: controller.greeting,
                                  fontSize: 16,
                                  variant: TextVariant.medium,
                                  color: kcTextBlackcolor,
                                ),
                              ),
                              verticalSpace(10),
                              FadeInUp(
                                delay: const Duration(milliseconds: 200),
                                child: CustomText(
                                  text: AppStrings.letMeHelpYou,
                                  fontSize: 13,
                                  color: kcTextGreyColor,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // ── Chat messages list ─────────────────────────────────
                    return ListView.builder(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return _buildMessageItem(context, msg, index, messages);
                      },
                    );
                  }),
                ),

                // ── Suggestions + input ────────────────────────────────────`
                Obx(
                  () => controller.messages.isNotEmpty
                      ? const SizedBox.shrink()
                      : const SuggestionsSection(),
                ),
                SafeArea(top: false, child: const ChatField()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(
    BuildContext context,
    ChatMessage msg,
    int index,
    List<ChatMessage> allMessages,
  ) {
    switch (msg.type) {
      case ChatMessageType.user:
        return ChatBubble(message: msg);

      case ChatMessageType.agentResponse:
        final processItems = _getProcessItemsForResponse(index, allMessages);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (processItems.isNotEmpty) StepsTrigger(items: processItems),
            ChatBubble(message: msg),
          ],
        );

      case ChatMessageType.agentStep:
        // Only show if it's the LATEST step in a sequence AND the turn is still active
        // A turn is active if there is no agentResponse AFTER this step.
        bool hasResponseAfter = false;
        bool isLastStepInSequence = true;

        for (int j = index + 1; j < allMessages.length; j++) {
          if (allMessages[j].type == ChatMessageType.agentResponse) {
            hasResponseAfter = true;
            break;
          }
          if (allMessages[j].type == ChatMessageType.agentStep) {
            isLastStepInSequence = false;
          }
        }

        // Also check if there is a booking confirmed or error after, which also ends the turn
        if (!hasResponseAfter) {
          for (int j = index + 1; j < allMessages.length; j++) {
            final t = allMessages[j].type;
            if (t == ChatMessageType.bookingConfirmed ||
                t == ChatMessageType.error) {
              hasResponseAfter = true;
              break;
            }
          }
        }

        if (!hasResponseAfter && isLastStepInSequence) {
          return StepCard(step: msg.step!);
        }
        return const SizedBox.shrink();

      case ChatMessageType.bookingConfirmed:
        return BookingCard(booking: msg.booking!);

      case ChatMessageType.loading:
        return const ThinkingIndicator();

      case ChatMessageType.agentThought:
        bool hasResponseAfter = false;
        bool isLastThoughtInSequence = true;

        for (int j = index + 1; j < allMessages.length; j++) {
          final t = allMessages[j].type;
          if (t == ChatMessageType.agentResponse ||
              t == ChatMessageType.bookingConfirmed ||
              t == ChatMessageType.error) {
            hasResponseAfter = true;
            break;
          }
          if (t == ChatMessageType.agentThought) {
            isLastThoughtInSequence = false;
          }
        }
        if (!hasResponseAfter && isLastThoughtInSequence) {
          return ThoughtBubble(text: msg.text ?? '');
        }
        return const SizedBox.shrink();

      case ChatMessageType.error:
        if (msg.text == "Response cancelled by user." ||
            msg.text == "You cancelled request") {
          return ChatBubble(
            message: ChatMessage.error("You cancelled request"),
          );
        }
        return ChatBubble(message: msg);
    }
  }

  /// Finds all [agentStep] and [agentThought] messages that preceded this response.
  List<ChatMessage> _getProcessItemsForResponse(
    int responseIdx,
    List<ChatMessage> all,
  ) {
    final List<ChatMessage> items = [];
    // Look backward from the response until we hit a user message or another response
    for (int i = responseIdx - 1; i >= 0; i--) {
      if (all[i].type == ChatMessageType.user ||
          all[i].type == ChatMessageType.agentResponse) {
        break;
      }
      if (all[i].type == ChatMessageType.agentStep ||
          all[i].type == ChatMessageType.agentThought) {
        items.insert(0, all[i]);
      }
    }
    return items;
  }
}
