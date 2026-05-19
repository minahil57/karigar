import 'package:karigar/export.dart';

class ProfileStatsRow extends StatelessWidget {
  final ProviderData provider;

  const ProfileStatsRow({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            context,
            Iconsax.briefcase,
            provider.totalBookings?.toString() ?? '0',
            AppStrings.jobsDone,
          ),
          _buildDivider(),
          _buildStat(
            context,
            Iconsax.timer,
            '${provider.responseTime}m',
            AppStrings.responseTimeLabel,
          ),
          _buildDivider(),
          _buildStat(
            context,
            Iconsax.star1,
            provider.rating.toString(),
            AppStrings.ratingLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, size: 18, color: kcBlackColor),
        verticalSpaceTiny,
        CustomText(
          text: value,
          variant: TextVariant.bold,
          fontSize: 14,
          color: kcBlackColor,
        ),
        CustomText(text: label, fontSize: 10, color: kcTextLightGrey),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: kcborderColor.withValues(alpha: 0.5),
    );
  }
}
