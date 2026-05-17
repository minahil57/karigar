import 'package:karigar/export.dart';
import 'package:karigar/widgets/custom_skeleton.dart';

class WorkHistoryScreen extends StatelessWidget {
  const WorkHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WorkHistoryController());
    return CustomLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<WorkHistoryController>(
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return CustomSkeleton(
                      enabled: true,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.historyList.length,
                        itemBuilder: (context, index) {
                          return WorkHistoryCard(
                            history: controller.historyList[index],
                          );
                        },
                      ),
                    );
                  }

                  final list = controller.filteredList;
                  if (list.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: 'No jobs found',
                        fontSize: 14,
                        color: kcTextLightGrey,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return WorkHistoryCard(history: list[index]);
                    },
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Load More',
                    variant: TextVariant.medium,
                    fontSize: 12,
                    color: kcTextGreyColor,
                  ),
                  horizontalSpaceTiny,
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: kcTextGreyColor,
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
