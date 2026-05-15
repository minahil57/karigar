import 'package:karigar/export.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  DioHelper.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  HttpOverrides.global = AppHttpOverrides();

  runApp(
     ChangeNotifierProvider<AppNotifier>(
        create: (context) => AppNotifier(),
        child: const KarigarApp(),
      ),
    );
}
