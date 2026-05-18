import 'package:karigar/export.dart';

class CustomNotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime? time;

  const CustomNotificationCard({
    super.key,
    required this.title,
    required this.body,
    this.time,
  });

  String getTimeLabel() {
    final difference = DateTime.now().difference(time ?? DateTime.now());

    if (difference.inMinutes < 1) {
      return "now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else {
      return "${time?.day}/${time?.month}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFE9EEEA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kcBlackColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CustomAssetsImage(
              imagePath: AppImages.logoWithoutName,
              height: 50,
              width: 50,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: title,
                          fontSize: 14,
                          variant: TextVariant.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      CustomText(
                        text: time == null ? "now" : getTimeLabel(),
                        fontSize: 10,
                        variant: TextVariant.regular,
                      
                        color: Color(0xFF3F3F3F),
                      ),
                    ],
                  ),


                  CustomText(
                    text: body,
                    fontSize: 12,
                    variant: TextVariant.regular,
               
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  color:  Color(0xFF3F3F3F),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
