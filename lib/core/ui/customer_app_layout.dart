import 'package:karigar/export.dart';

class CustomerAppLayout extends StatelessWidget {
  const CustomerAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      tabNames: const ["Karigar AI", "Community", 'Profile'],
      tabPages: [
           const AgentView(),
        const Center(
          child: CustomText(text: "Community Coming Soon", fontSize: 16),
        ),
        const Center(
          child: CustomText(text: "Profile Coming Soon", fontSize: 16),
        ),
      ],
    );
  }
}
