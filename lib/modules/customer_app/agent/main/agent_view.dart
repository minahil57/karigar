import 'package:karigar/export.dart';

class AgentView extends StatelessWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AgentController>();
    return CustomLayout(child: Column(children: []));
  }
}
