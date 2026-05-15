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
                padding: const EdgeInsets.only(left: 17, right: 17, top: 100),
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
                  height: 300,
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
                      bottom: 60,
                      left: 40,
                      right: 40,
                      child: CustomButton(
                        text: 'Get Started',
                        onPressed: controller.nextPage,
                        minSize: const Size(double.infinity, 51),
                        maxSize: const Size(double.infinity, 51),
                        textColor: Colors.white,
                      ),
                    )
                  : controller.currentPage == controller.pages.length - 1
                  ? Positioned(
                      bottom: 60,
                      left: 40,
                      right: 40,
                      child: CustomButton(
                        text: 'Sign In',
                        onPressed: controller.nextPage,
                        minSize: const Size(double.infinity, 51),
                        maxSize: const Size(double.infinity, 51),
                        textColor: Colors.white,
                      ),
                    )
                  : Positioned(
                      bottom: 60,
                      left: 17,
                      right: 17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.currentPage != 0
                              ? GestureDetector(
                                  onTap: controller.previousPage,
                                  child: CustomText(
                                    text: 'Back',
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
      top: 100,
      left: 17,
      right: 17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmoothGrainyText(
            text: controller.pages[controller.currentPage].title,
            style: GoogleFonts.ibmPlexSerif(
              fontWeight: FontWeight.w400,
              fontSize: 32,
              color: Colors.black,
              letterSpacing: 0,
              height: 0.8,
            ),
            brownIndexes: controller.pages[controller.currentPage].brownIndex,
          ),
          verticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SmoothGrainyText(
              text: controller.pages[controller.currentPage].subtitle,
              style: GoogleFonts.ibmPlexSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
                letterSpacing: 0,
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
          bottom: getbottomSpace(pageData.id),
          left: 0,
          right: 0,
          child: SlideInUp(
            duration: const Duration(milliseconds: 800),
            child: Image.asset(
              pageData.imagePath,
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 569,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => controller.previousPage(),
            child: Container(color: Colors.transparent),
          ),
        ),

        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => controller.nextPage(),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
