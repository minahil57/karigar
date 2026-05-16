import 'package:karigar/export.dart';

class AppLayout extends StatefulWidget {
  final Widget? child;
  final List<String>? tabNames;
  final List<Widget>? tabPages;
  final int initialIndex;
  final bool useSafeArea;
  final Widget? endDrawer;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AppLayout({
    super.key,
    this.child,
    this.tabNames,
    this.tabPages,
    this.initialIndex = 0,
    this.useSafeArea = true,
    this.endDrawer,
    this.drawer,
    this.appBar,
    this.scaffoldKey,
  }) : assert(child != null || (tabNames != null && tabPages != null));

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: double.infinity,
      height: double.infinity,
      color: kcBackgroundColor,
      child: Column(
        children: [
          if (widget.tabNames != null) _buildTabBar(),
          Expanded(
            child: widget.tabNames != null
                ? widget.tabPages![_selectedIndex]
                : widget.child!,
          ),
        ],
      ),
    );

    return Scaffold(
      key: widget.scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: widget.appBar,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      body: widget.useSafeArea ? SafeArea(child: content) : content,
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.tabNames!.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              if (_selectedIndex != index) {
                setState(() => _selectedIndex = index);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.tabNames![index],
                    fontSize: 18,
                    variant: isSelected
                        ? TextVariant.medium
                        : TextVariant.regular,
                    color: isSelected ? kcPrimaryColor : kcTextGreyColor,
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 3,
                    width: isSelected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: kcSecondaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
