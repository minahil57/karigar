import 'package:karigar/export.dart';

class WorkHistoryTabs extends StatelessWidget {
  const WorkHistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WorkHistoryController>();

    return Row(
      children: [
        _buildTab(context, 'All Jobs', 0, controller),
        _buildTab(context, 'Completed', 1, controller),
        _buildTab(context, 'Cancelled', 2, controller),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String label, int index, WorkHistoryController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
          final isSelected = controller.selectedTabIndex.value == index;
          return Column(
            children: [
              CustomText(
                text: label,
                variant: isSelected ? TextVariant.bold : TextVariant.regular,
                fontSize: 12,
                color: isSelected ? kcPrimaryColor : kcTextLightGrey,
              ),
              verticalSpaceTiny,
              Container(
                height: 2,
                width: 40,
                decoration: BoxDecoration(
                  color: isSelected ? kcPrimaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
