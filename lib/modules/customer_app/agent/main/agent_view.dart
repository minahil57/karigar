import 'package:karigar/export.dart';

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
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kcWhitecolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kcBlackColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
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
                      return _buildMessageItem(msg);
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

  Widget _buildMessageItem(ChatMessage msg) {
    switch (msg.type) {
      case ChatMessageType.user:
      case ChatMessageType.agentResponse:
        return ChatBubble(message: msg);

      case ChatMessageType.agentStep:
        return StepCard(step: msg.step!);

      case ChatMessageType.bookingConfirmed:
        return BookingCard(booking: msg.booking!);

      case ChatMessageType.loading:
        return const ThinkingIndicator();

      case ChatMessageType.error:
        return ChatBubble(message: msg);
    }
  }
}
