import 'package:karigar/export.dart';

class CustomSegmentedTab extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CustomSegmentedTab({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  int get _safeSelectedIndex {
    if (items.isEmpty) return 0;
    if (selectedIndex < 0 || selectedIndex >= items.length) return 0;
    return selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final int activeIndex = _safeSelectedIndex;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
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
                        ? -1 + (activeIndex * 2 / (items.length - 1))
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
                  children: List.generate(items.length, (index) {
                    final bool isSelected = index == activeIndex;
                    final Color labelColor = isSelected
                        ? Colors.white
                        : kcDarkGreyTextColor;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (index != activeIndex) {
                            onChanged(index);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 4,
                          ),
                          color: Colors.transparent,
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: getMediumStyle(
                                fontSize: 11,
                                color: labelColor,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  items[index],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: getMediumStyle(
                                    fontSize: 11,
                                    color: labelColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
