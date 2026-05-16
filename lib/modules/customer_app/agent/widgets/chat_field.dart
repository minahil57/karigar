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
                      color: kcTextGreyColor,
                    ),
                  ),
                ),
                horizontalSpace(10),
                InkWell(
                  onTap: controller.sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: kcSecondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Iconsax.send_1, color: kcWhitecolor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
