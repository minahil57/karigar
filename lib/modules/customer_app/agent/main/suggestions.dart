import 'dart:ui';

import 'package:karigar/export.dart';

class SuggestionsSection extends StatelessWidget {
  const SuggestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgentController>(
      builder: (controller) {
        return FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.suggestions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final suggestion = controller.suggestions[index];
                return ZoomIn(
                  delay: Duration(milliseconds: 400 + (index * 100)),
                  child: GestureDetector(
                    onTap: () => controller.sendMessage(
                      customText: suggestion['title']!,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                            color: kcWhitecolor.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: kcWhitecolor.withValues(alpha: 0.8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                suggestion['icon'] == 'electrician'
                                    ? Iconsax.flash
                                    : suggestion['icon'] == 'painter'
                                    ? Iconsax.brush
                                    : Iconsax.airdrop,
                                size: 18,
                                color: kcSecondaryColor,
                              ),
                              horizontalSpace(10),
                              CustomText(
                                text: suggestion['title']!,
                                fontSize: 13,
                                color: kcTextBlackcolor,
                                variant: TextVariant.medium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
