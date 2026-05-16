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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const CustomText(
                  text: AppStrings.suggestionsForYou,
                  fontSize: 14,
                  variant: TextVariant.medium,
                  color: kcTextBlackcolor,
                ),
              ),
              verticalSpace(15),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.suggestions.length,
                  separatorBuilder: (context, index) => horizontalSpace(15),
                  itemBuilder: (context, index) {
                    final suggestion = controller.suggestions[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 160,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: kcWhitecolor.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: kcWhitecolor.withValues(alpha: 0.8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              verticalSpace(8),
                              CustomText(
                                text: suggestion['title']!,
                                fontSize: 14,
                                color: kcTextBlackcolor,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
