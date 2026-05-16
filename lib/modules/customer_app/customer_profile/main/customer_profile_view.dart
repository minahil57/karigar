import 'package:karigar/export.dart';

class CustomerProfileView extends StatelessWidget {
  const CustomerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerProfileController());
    return CustomLayout(
      child: Column(
        children: [
          CustomOutlineButton(
            backgroundColor: kcErrorColor,
            textColor: kcWhitecolor,
            borderColor: kcErrorColor,
            text: 'Logout',
            onPressed: () {
              AuthRepository.localLogout();
            },
          ),
        ],
      ),
    );
  }
}
