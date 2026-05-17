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
                if (!controller.isIputEmpty.value) ...[
                  horizontalSpace(10),
                  InkWell(
                    onTap: controller.sendMessage,
                    child: SlideInRight(
                      child: Container(
                        alignment: Alignment.center,
                        height: 45.w,
                        width: 45.w,
                        decoration: const BoxDecoration(
                          color: kcSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.send_1,
                          color: kcWhitecolor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
