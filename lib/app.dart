import 'package:karigar/export.dart';

class KarigarApp extends StatelessWidget {
  const KarigarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return GetMaterialApp(
                title: 'Karigar',
                debugShowCheckedModeBanner: false,
                translations: AppTranslations(),
                locale: LocalizationService.currentLocale,
                fallbackLocale: LocalizationService.fallbackLocale,
                scrollBehavior: CustomScrollBehavior(),
                theme: MainAppTheme.lightTheme,
                darkTheme: MainAppTheme.darkTheme,
                themeMode: ThemeMode.light,
                initialRoute: AppRouter.initialRoute,
                getPages: AppRouter.pages(),
                builder: (context, child) {
                  child = ResponsiveBreakpoints.builder(
                    child: child!,
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 1200, name: TABLET),
                      const Breakpoint(
                        start: 1201,
                        end: double.infinity,
                        name: DESKTOP,
                      ),
                    ],
                  );

                  return EasyLoading.init()(context, child);
                },
              );
            },
          ),
        );
      },
    );
  }
}
