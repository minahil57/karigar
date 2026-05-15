import 'package:karigar/export.dart';

class WorkHistoryScreen extends StatelessWidget {
  const WorkHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WorkHistoryController>();

    return CustomLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            verticalSpaceSmall,
            const WorkHistoryHeader(),
            verticalSpaceMedium,
            const WorkHistoryTabs(),
            verticalSpaceMedium,
            Expanded(
              child: Obx(() {
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
              }),
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
