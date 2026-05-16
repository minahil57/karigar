import 'package:karigar/export.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          variant: TextVariant.bold,
          fontSize: getResponsiveFontSize(context, fontSize: 14, max: 16),
          color: kcBlackColor,
        ),
        TextButton(
          onPressed: onViewAll,
          child: Row(
            children: [
              CustomText(
                text: AppStrings.viewAll,
                variant: TextVariant.medium,
                color: kcTextGreyColor,
                fontSize: getResponsiveFontSize(context, fontSize: 11, max: 13),
              ),
              Icon(
                Icons.chevron_right,
                size: getResponsiveFontSize(context, fontSize: 14, max: 16),
                color: kcTextGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
