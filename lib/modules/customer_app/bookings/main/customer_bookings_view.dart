import 'package:karigar/export.dart';
import 'package:karigar/widgets/custom_skeleton.dart';

class CustomerBookingsView extends StatelessWidget {
  const CustomerBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerBookingsController());
    return CustomLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<CustomerBookingsController>(
                  id: 'bookings',
                  builder: (controller) {
                    if (controller.isLoading) {
                      return CustomSkeleton(
                        enabled: controller.isLoading,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.bookings.length,
                          itemBuilder: (context, index) {
                            return WorkHistoryCard(
                              history: controller.bookings[index],
                            );
                          },
                        ),
                      );
                    }

                    final list = controller.bookings;
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
      ),
    );
  }
}
