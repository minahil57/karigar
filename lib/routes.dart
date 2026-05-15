import 'package:karigar/export.dart';

class Routes {
  static const String login = '/auth/login';
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String createAccount = '/auth/create_account';
}

class AppRouter {
  static String initialRoute = Routes.splash;

  static List<GetPage> pages() {
    return [
      GetPage(
        name: Routes.splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: Routes.onboarding,
        page: () => const OnboardingView(),
        binding: OnboardingBinding(),
      ),
      GetPage(
        name: Routes.login,
        page: () => const LoginView(),
        binding: LoginBindings(),
      ),
      GetPage(
        name: Routes.createAccount,
        page: () => const CreateAccountView(),
        binding: CreateAccountBinding(),
      ),
    ];
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // log(route.toString());
    if (!AuthRepository.isLoggedIn) {
      // log('here');
      return const RouteSettings(name: Routes.login);
    }
    // log('here 2');
    return null;
  }
}
