import 'package:karigar/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  DioHelper.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  HttpOverrides.global = AppHttpOverrides();
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = kcBlackColor
    ..textColor = kcWhitecolor
    ..indicatorColor = kcWhitecolor
    ..userInteractions = false
    ..radius = 14
    ..indicatorSize = 30
    ..dismissOnTap = false
    ..maskColor = Colors.transparent;

  runApp(
    ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: const KarigarApp(),
    ),
  );
}
