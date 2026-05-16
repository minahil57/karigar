import 'package:karigar/export.dart';

class ProfileStatsRow extends StatelessWidget {
  final ProfileModel profile;

  const ProfileStatsRow({
    super.key,
    required this.profile,
  });

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
          _buildStat(context, Iconsax.briefcase, profile.jobsCompleted, 'Jobs Completed'),
          _buildDivider(),
          _buildStat(context, Iconsax.verify, profile.successRate, 'Success Rate'),
          _buildDivider(),
          _buildStat(context, Iconsax.star1, profile.avgRating, 'Avg. Rating'),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String value, String label) {
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
        CustomText(
          text: label,
          fontSize: 10,
          color: kcTextLightGrey,
        ),
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
