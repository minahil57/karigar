import 'package:karigar/export.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<OnboardingController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildTitleAndSubtitle(controller),
              Padding(
                padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 100.h),
                child: PageView.builder(
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
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: context.height * (300 / 690),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.01),
                        Colors.white.withValues(alpha: 0.9),
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),

              controller.currentPage == 0
                  ? Positioned(
                      bottom: 60.h,
                      left: 40.w,
                      right: 40.w,
                      child: CustomButton(
                        text: AppStrings.getStarted,
                        onPressed: controller.nextPage,
                        minSize: Size(double.infinity, 51.h),
                        maxSize: Size(double.infinity, 51.h),
                        textColor: Colors.white,
                      ),
                    )
                  : controller.currentPage == controller.pages.length - 1
                  ? Positioned(
                      bottom: 60.h,
                      left: 40.w,
                      right: 40.w,
                      child: CustomButton(
                        text: AppStrings.signIn,
                        onPressed: controller.nextPage,
                        minSize: Size(double.infinity, 51.h),
                        maxSize: Size(double.infinity, 51.h),
                        textColor: Colors.white,
                      ),
                    )
                  : Positioned(
                      bottom: 60.h,
                      left: 17.w,
                      right: 17.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.currentPage != 0
                              ? GestureDetector(
                                  onTap: controller.previousPage,
                                  child: CustomText(
                                    text: AppStrings.back,
                                    fontSize: 16,
                                    variant: TextVariant.regular,
                                  ),
                                )
                              : const SizedBox(),

                          CustomProgressButton(
                            ontap: () {
                              log('ontap');
                              controller.nextPage();
                            },
                            progress: controller.progress,
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleAndSubtitle(OnboardingController controller) {
    return Positioned(
      top: 100.h,
      left: 17.w,
      right: 17.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmoothGrainyText(
            text: controller.pages[controller.currentPage].title,
            style: TextStyle(
              fontFamily: 'Sora',
              fontWeight: FontWeight.w400,
              fontSize: 32.sp,
              color: Colors.black,
              height: 0.8,
            ),
            brownIndexes: controller.pages[controller.currentPage].brownIndex,
          ),
          verticalSpace(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SmoothGrainyText(
              text: controller.pages[controller.currentPage].subtitle,
              style: TextStyle(
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Colors.black,
                height: 0.8,
              ),
              brownIndexes: const [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
    OnboardingPageModel pageData,
    BuildContext context,
    OnboardingController controller,
  ) {
    return Stack(
      children: [
        Positioned(
          bottom: getbottomSpace(pageData.id).h,
          left: 0,
          right: 0,
          child: SlideInUp(
            duration: const Duration(milliseconds: 800),
            child: Image.asset(
              pageData.imagePath,
              width: context.width * 0.8,
              height: context.height * (569 / 690),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: context.width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => controller.previousPage(),
            child: Container(color: Colors.transparent),
          ),
        ),

        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: context.width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => controller.nextPage(),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
