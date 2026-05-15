import 'package:karigar/export.dart';

class AgentController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  
  final List<Map<String, String>> suggestions = [
    {
      'title': "What's available for investment with 10% ROI?",
      'icon': 'roi',
    },
    {
      'title': "Most off-plan projects handing over in 2027",
      'icon': 'plan',
    },
    {
      'title': "Luxury penthouses in Downtown Dubai",
      'icon': 'luxury',
    },
  ];

  String get greeting => "${AppStrings.hey} ${getUser()?.name ?? 'User'}!";

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      // Handle send message logic here
      messageController.clear();
      update();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}