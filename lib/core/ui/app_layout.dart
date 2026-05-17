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
  final Function(int)? tabChangeCallBack;

  const AppLayout({
    super.key,
    this.child,
    this.tabNames,
    this.tabPages,
    this.initialIndex = 1,
    this.useSafeArea = true,
    this.endDrawer,
    this.drawer,
    this.appBar,
    this.tabChangeCallBack,
    this.scaffoldKey,
  }) : assert(child != null || (tabNames != null && tabPages != null));

  static AppLayoutState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppLayoutState>();
  }

  @override
  State<AppLayout> createState() => AppLayoutState();
}

class AppLayoutState extends State<AppLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      widget.tabChangeCallBack?.call(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CustomLayout(
      child: Column(
        children: [
          if (widget.tabNames != null)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildTabBar(),
              ),
            ),
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
      body: widget.useSafeArea ? content : content,
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: widget.tabNames![index],
                  fontSize: 16,
                  variant: isSelected
                      ? TextVariant.medium
                      : TextVariant.regular,
                  color: isSelected ? kcPrimaryColor : kcTextGreyColor,
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  width: isSelected ? 50 : 0,
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
    );
  }
}
