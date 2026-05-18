import 'package:karigar/export.dart';
import 'package:karigar/modules/customer_app/community/main/community_map_view.dart';
import 'package:karigar/widgets/custom_skeleton.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommunityController());
    return GetBuilder<CommunityController>(
      id: 'providers',
      builder: (controller) {
        return CustomLayout(
          child: Column(
            children: [
              GetBuilder<CommunityController>(
                id: 'view-type',
                builder: (controller) {
                  return controller.isMapView
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.searchController,
                                      hintText: AppStrings.searchForKarigars,
                                      prefixIcon: const Icon(
                                        Iconsax.search_normal,
                                      ),
                                      onChanged: controller.onSearchChanged,
                                    ),
                                  ),
                                  horizontalSpace(12),
                                  ViewToggleButton(),
                                ],
                              ),
                            ),
                            verticalSpace(12),
                          ],
                        );
                },
              ),
              Expanded(
                child: GetBuilder<CommunityController>(
                  id: 'view-type',
                  builder: (controller) {
                    if (controller.isMapView) {
                      return CommunityMapView();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomSkeleton(
                        enabled: controller.isLoading,
                        child: controller.errorMessage.isNotEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      fontSize: 14,
                                      text: controller.errorMessage,
                                      color: kcErrorColor,
                                    ),
                                    verticalSpace(10),
                                    CustomOutlineButton(
                                      text: AppStrings.retry,
                                      onPressed: controller.fetchProviders,
                                      height: 40,
                                    ),
                                  ],
                                ),
                              )
                            : controller.filteredProviders.isEmpty &&
                                  !controller.isLoading
                            ? Center(
                                child: CustomText(
                                  fontSize: 14,
                                  text: AppStrings.noProvidersFound,
                                  color: kcTextGreyColor,
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.isLoading
                                    ? 5
                                    : controller.filteredProviders.length,
                                separatorBuilder: (_, _) => verticalSpace(15),
                                itemBuilder: (context, index) {
                                  final provider = controller.isLoading
                                      ? dummyProvidersList[index]
                                      : controller.filteredProviders[index];
                                  return ProviderCard(provider: provider);
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
