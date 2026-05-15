import 'package:karigar/export.dart';

class AgentView extends StatelessWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgentController>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return CustomerAppLayout(
      scaffoldKey: scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: kcPrimaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAssetsImage(
                    imagePath: 'assets/images/logo.png',
                    height: 200,
                  ),
                  verticalSpace(10),
                  CustomText(
                    text: AppStrings.appTitle,
                    color: kcWhitecolor,
                    fontSize: 20,
                    variant: TextVariant.medium,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Iconsax.home),
              title: const Text(AppStrings.home),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Iconsax.user),
              title: const Text(AppStrings.profile),
              onTap: () => Get.back(),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.logout),
              title: const Text('Logout'),
              onTap: () => AuthRepository.logout(),
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomAssetsImage(
                  imagePath: 'assets/images/logo.png',
                  height: 40,
                ),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(Iconsax.menu_1, color: kcPrimaryColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Center(
                child: Column(
                  children: [
                    verticalSpace(40),
                    FadeInDown(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kcWhitecolor,
                          boxShadow: [
                            BoxShadow(
                              color: kcBlackColor.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const CustomAssetsImage(
                          imagePath: 'assets/images/logo.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    FadeInUp(
                      child: CustomText(
                        text: controller.greeting,
                        fontSize: 24,
                        variant: TextVariant.medium,
                        color: kcTextBlackcolor,
                      ),
                    ),
                    verticalSpace(10),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: CustomText(
                        text: AppStrings.letMeHelpYou,
                        fontSize: 16,
                        color: kcTextGreyColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SuggestionsSection(),
          ChatField(),
          verticalSpace(10),
        ],
      ),
    );
  }
}
