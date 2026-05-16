import 'package:karigar/export.dart';
import 'package:karigar/widgets/custom_skeleton.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    final bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final bool isTablet = ResponsiveBreakpoints.of(context).isTablet;

    final double horizontalPadding = isMobile
        ? 20
        : isTablet
        ? 40
        : 80;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return CustomLayout(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                CustomSkeleton(
                  enabled: controller.isLoading,
                  child: ProviderProfileCard(
                    provider: controller.provider ?? dummyProvider,
                  ),
                ),
                verticalSpaceSmall,
                HomeSectionHeader(
                  title: AppStrings.liveServiceRequests,
                  onViewAll: () {
                    // Get.toNamed(Routes.workHistory);
                  },
                ),
                _buildServiceRequestList(context, controller, isMobile),
                verticalSpaceLarge,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceRequestList(
    BuildContext context,
    HomeController controller,
    bool isMobile,
  ) {
    if (!isMobile) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 220,
        ),
        itemCount: controller.serviceRequests.length,
        itemBuilder: (context, index) {
          final request = controller.serviceRequests[index];
          return ServiceRequestCard(
            request: request,
            onAccept: () {},
            onReject: () {},
          );
        },
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.serviceRequests.length,
      separatorBuilder: (context, index) => verticalSpaceSmall,
      itemBuilder: (context, index) {
        final request = controller.serviceRequests[index];
        return ServiceRequestCard(
          request: request,
          onAccept: () {},
          onReject: () {},
        );
      },
    );
  }
}
