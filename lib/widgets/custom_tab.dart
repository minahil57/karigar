import 'package:karigar/export.dart';

class CustomSegmentedTab extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const CustomSegmentedTab({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = items.indexOf(selectedValue);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kcTabDisableColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: kcborderColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = constraints.maxWidth / items.length;

          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment(
                  items.length > 1
                      ? -1 + (selectedIndex * 2 / (items.length - 1))
                      : 0,
                  0,
                ),
                child: Container(
                  width: itemWidth,
                  height: 48,
                  decoration: BoxDecoration(
                    color: kcSecondaryColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: kcSecondaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: items.map((item) {
                  final bool isSelected = item == selectedValue;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(item),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.transparent,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: getMediumStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? Colors.white
                                  : kcDarkGreyTextColor,
                            ),
                            child: Text(
                              item,
                              style: getMediumStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? Colors.white
                                    : kcDarkGreyTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
