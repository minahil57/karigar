import 'package:karigar/export.dart';

class ChatField extends StatelessWidget {
  const ChatField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgentController>(
      builder: (controller) {
        return FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.messageController,
                    hintText: AppStrings.writeYourMessage,
                    suffixIcon: const Icon(
                      Iconsax.microphone,
                      size: 19,
                      color: kcTextGreyColor,
                    ),
                  ),
                ),
                Obx(() {
                  final isThinking = controller.isThinking.value;
                  final isInputEmpty = controller.isIputEmpty.value;

                  if (!isThinking && isInputEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: isThinking
                          ? controller.cancelResponse
                          : controller.sendMessage,
                      child: SlideInRight(
                        child: Container(
                          alignment: Alignment.center,
                          height: 45.w,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: isThinking ? kcErrorColor : kcSecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isThinking ? Icons.stop_rounded : Iconsax.send_1,
                            color: kcWhitecolor,
                            size: isThinking ? 22 : 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
