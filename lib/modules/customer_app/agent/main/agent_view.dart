import 'package:karigar/export.dart';

class AgentView extends StatelessWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentController());
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            kcSecondaryColor.withValues(alpha: 0.2),
            kcSecondaryColor.withValues(alpha: 0.05),
            kcSecondaryColor.withValues(alpha: 0),
          ],
        ),
      ),
      child: Stack(
        children: [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                                  color: kcBlackColor.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const CustomAssetsImage(
                              imagePath: 'assets/images/logo.png',
                              height: 120,
                              width: 120,
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
                ),
              ),
              const SuggestionsSection(),
              const ChatField(),
              verticalSpace(10),
            ],
          ),
        ],
      ),
    );
  }
}
