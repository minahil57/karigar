import 'package:karigar/export.dart';

class ProviderAppLayout extends StatelessWidget {
  const ProviderAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      tabNames: const ["Work History", "Home", 'Profile'],
      tabPages: [
        const WorkHistoryScreen(),
        const ProviderHomeScreen(),
        const ProviderProfileScreen(),
      ],
    );
  }
}
