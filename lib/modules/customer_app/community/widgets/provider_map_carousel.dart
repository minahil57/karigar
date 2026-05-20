import 'package:karigar/export.dart';

class ProviderMapCarousel extends StatefulWidget {
  final List<ProviderData> providers;
  final int initialIndex;
  final VoidCallback onDismiss;
  final ValueChanged<int>? onPageChanged;

  const ProviderMapCarousel({
    super.key,
    required this.providers,
    this.initialIndex = 0,
    required this.onDismiss,
    this.onPageChanged,
  });

  @override
  State<ProviderMapCarousel> createState() => _ProviderMapCarouselState();
}

class _ProviderMapCarouselState extends State<ProviderMapCarousel> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.location, size: 14, color: kcSecondaryColor),
            horizontalSpaceTiny,
            CustomText(
              text: '${widget.providers.length} providers at this location',
              fontSize: 12,
              variant: TextVariant.medium,
              color: kcTextGreyColor,
            ),
          ],
        ),
        verticalSpaceSmall,
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.providers.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (_, index) => ProviderMapCard(
              provider: widget.providers[index],
              onDismiss: widget.onDismiss,
            ),
          ),
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.providers.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? kcSecondaryColor : kcborderColor,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
