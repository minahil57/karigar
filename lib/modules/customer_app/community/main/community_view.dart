import 'package:karigar/export.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
      Get.lazyPut(() => CommunityController());
    return CustomLayout(
      child: Column(
        children: [

        ],
      )
    );
  }
}