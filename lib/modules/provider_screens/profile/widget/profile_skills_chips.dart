import 'package:karigar/export.dart';

class ProfileSkillsChips extends StatelessWidget {
  final List<String> skills;

  const ProfileSkillsChips({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Iconsax.briefcase, size: 16, color: kcTextLightGrey),
            horizontalSpaceSmall,
            const CustomText(
              text: 'Skills',
              fontSize: 12,
              color: kcTextGreyColor,
            ),
          ],
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.1)),
            ),
            child: CustomText(
              text: skill,
              fontSize: 10,
              color: kcPrimaryColor,
              variant: TextVariant.medium,
            ),
          )).toList(),
        ),
      ],
    );
  }
}
