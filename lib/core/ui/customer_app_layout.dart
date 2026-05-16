import 'package:karigar/export.dart';

class CustomerAppLayout extends StatelessWidget {
  const CustomerAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      tabNames: const ["Community", "Karigar AI", 'Profile'],
      tabPages: [
        const CommunityView(),
        const AgentView(),
        CustomerProfileView()
      ],
    );
  }
}
