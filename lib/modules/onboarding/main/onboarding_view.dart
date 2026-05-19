import 'package:karigar/export.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<OnboardingController>(
        builder: (controller) {
          return Column(
            children: [
              // Top Portion: Sliding Onboarding Images (takes ~55% height)
              Expanded(
                flex: 55,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(top: kToolbarHeight),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: controller.pages.length,
                        itemBuilder: (context, index) {
                          return _buildOnboardingPage(
                            controller.pages[index],
                            context,
                            controller,
                          );
                        },
                      ),
                      // Elegant fade layer at the bottom of the image and above the title
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 180.h,
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.0),
                                  Colors.white.withValues(alpha: 0.3),
                                  Colors.white.withValues(alpha: 0.8),
                                  Colors.white,
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Portion: Clean card with solid white background (takes ~45% height)
              Expanded(
                flex: 45,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Dynamic Title and Subtitle Text
                          Column(
                            children: [
                              SmoothGrainyText(
                                text: controller
                                    .pages[controller.currentPage]
                                    .title,
                                style: appTextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                brownIndexes: controller
                                    .pages[controller.currentPage]
                                    .brownIndex,
                              ),
                              verticalSpace(16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SmoothGrainyText(
                                  text: controller
                                      .pages[controller.currentPage]
                                      .subtitle,
                                  style: appTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: kcDarkGreyTextColor,
                                  ),
                                  brownIndexes: const [],
                                ),
                              ),
                            ],
                          ),

                          // Dynamic Action Buttons
                          _buildButtons(context, controller),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButtons(BuildContext context, OnboardingController controller) {
    if (controller.currentPage == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomButton(
          text: AppStrings.getStarted,
          onPressed: controller.nextPage,
          width: context.width * 0.7,
          height: 45.h,

          textColor: Colors.white,
        ),
      );
    } else if (controller.currentPage == controller.pages.length - 1) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomButton(
          text: AppStrings.signIn,
          onPressed: controller.nextPage,
          width: context.width * 0.7,
          height: 45.h,
          textColor: Colors.white,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: controller.previousPage,
            behavior: HitTestBehavior.opaque,
            child: CustomText(
              text: AppStrings.back,
              fontSize: 16,
              variant: TextVariant.regular,
            ),
          ),
          CustomProgressButton(
            ontap: () {
              log('ontap');
              controller.nextPage();
            },
            progress: controller.progress,
          ),
        ],
      );
    }
  }

  Widget _buildOnboardingPage(
    OnboardingPageModel pageData,
    BuildContext context,
    OnboardingController controller,
  ) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        // Center-positioned illustration with smooth fade-in-up animation
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          from: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Image.asset(
              pageData.imagePath,
              fit: BoxFit.contain,
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
        ),

        // Left & Right Swipe/Tap Areas
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: context.width * 0.25,
          child: GestureDetector(
            onTap: controller.previousPage,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: context.width * 0.25,
          child: GestureDetector(
            onTap: controller.nextPage,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }
}
