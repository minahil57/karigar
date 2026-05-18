import 'package:karigar/export.dart';

class CustomerAppLayout extends StatelessWidget {
  const CustomerAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      tabNames: [AppStrings.communityTab, AppStrings.aiTab, AppStrings.profileTab],
      tabPages: [
        const CommunityView(),
        const AgentView(),
        CustomerProfileView()
      ],
    );
  }
}
