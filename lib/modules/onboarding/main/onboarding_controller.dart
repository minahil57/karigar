import 'package:karigar/export.dart';

class OnboardingController extends GetxController {

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    update();
  }


  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      id: 1,
      title: AppStrings.onboardingTitle1,
      subtitle: AppStrings.onboardingSubtitle1,
      imagePath: AppImages.onboardingSlide1,
      brownIndex: [1],
    ),

    OnboardingPageModel(
      id: 2,
      title: AppStrings.onboardingTitle2,
      subtitle: AppStrings.onboardingSubtitle2,
      imagePath: AppImages.onboardingSlide2,
      brownIndex: [1],
    ),

    OnboardingPageModel(
      id: 3,
      title: AppStrings.onboardingTitle3,
      subtitle: AppStrings.onboardingSubtitle3,
      imagePath: AppImages.onboardingSlide3,
      brownIndex: [1],
    ),

    OnboardingPageModel(
      id: 4,
      title: AppStrings.onboardingTitle4,
      subtitle: AppStrings.onboardingSubtitle4,
      imagePath: AppImages.onboardingSlide4,
      brownIndex: [1],
    ),
  ];

  List<OnboardingPageModel> get pages => _pages;


  void onPageChanged(int page) {
    currentPage = page;
  }


  void nextPage() {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      update();
    } else {
      Snackbars.info('Coming Soon!!');
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      update();
    }
  }


  void onGetStarted() {
    nextPage();
  }


  double get progress {
    switch (_currentPage) {
      case 1:
        return 0.33;
      case 2:
        return 0.66;
      case 3:
        return 0.99;
      case 4:
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
