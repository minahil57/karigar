import 'package:karigar/export.dart';

class AgentController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  
  final List<Map<String, String>> suggestions = [
    {
      'title': "Mujhe Ek Electrician chahiye ",
      'icon': 'electrician',
    },
    {
      'title': "Mujhe Ek Painter chahiye",
      'icon': 'painter',
    },
    {
      'title': "Mujhe Ek Plumber chahiye",
      'icon': 'plumber',
    },
  ];

  String get greeting {
    final hour = DateTime.now().hour;
    String g;
    if (hour < 12) {
      g = 'Good Morning';
    } else if (hour < 17) {
      g = 'Good Afternoon';
    } else {
      g = 'Good Evening';
    }
    return "$g, ${getUser()?.name ?? 'User'}!";
  }

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