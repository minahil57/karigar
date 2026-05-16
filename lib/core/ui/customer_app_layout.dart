import 'package:karigar/export.dart';

class CustomerAppLayout extends StatelessWidget {
  const CustomerAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      tabNames: const ["Community", "Karigar AI", 'Profile'],
      tabPages: [
        const Center(
          child: CustomText(text: "Community Coming Soon", fontSize: 16),
        ),
        const AgentView(),
        const Center(
          child: CustomText(text: "Profile Coming Soon", fontSize: 16),
        ),
      ],
    );
  }
}
