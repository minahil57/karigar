import 'package:karigar/export.dart';
import 'package:karigar/modules/customer_app/agent/widgets/steps_bottom_sheet.dart';

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
            bottom: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
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
          Column(
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
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kcWhitecolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kcBlackColor.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 40,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const CustomAssetsImage(
                                  imagePath: 'assets/images/logo.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            verticalSpace(20),
                            FadeInUp(
                              child: CustomText(
                                text: controller.greeting,
                                fontSize: 24,
                                variant: TextVariant.medium,
                                color: kcTextBlackcolor,
                              ),
                            ),
                            verticalSpace(10),
                            FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: CustomText(
                                text: AppStrings.letMeHelpYou,
                                fontSize: 16,
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
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
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
        final steps = _getStepsForResponse(index, allMessages);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatBubble(message: msg),
            if (steps.isNotEmpty) _buildStepsTrigger(context, steps),
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

      case ChatMessageType.error:
        return ChatBubble(message: msg);
    }
  }

  /// Finds all [agentStep] messages that preceded this response.
  List<AgentStep> _getStepsForResponse(int responseIdx, List<ChatMessage> all) {
    final List<AgentStep> steps = [];
    // Look backward from the response until we hit a user message or another response
    for (int i = responseIdx - 1; i >= 0; i--) {
      if (all[i].type == ChatMessageType.user ||
          all[i].type == ChatMessageType.agentResponse) {
        break;
      }
      if (all[i].type == ChatMessageType.agentStep && all[i].step != null) {
        steps.insert(0, all[i].step!);
      }
    }
    return steps;
  }

  Widget _buildStepsTrigger(BuildContext context, List<AgentStep> steps) {
    return Padding(
      padding: const EdgeInsets.only(left: 56, bottom: 10),
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            StepsBottomSheet(steps: steps),
            isScrollControlled: true,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: 'Steps',
              fontSize: 12,
              color: kcSecondaryColor,
              variant: TextVariant.medium,
            ),
            horizontalSpace(4),
            Icon(Icons.chevron_right, size: 14, color: kcSecondaryColor),
          ],
        ),
      ),
    );
  }
}
