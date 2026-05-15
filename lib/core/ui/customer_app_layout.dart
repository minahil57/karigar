import 'package:karigar/export.dart';

class CustomerAppLayout extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final Widget? endDrawer;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomerAppLayout({
    super.key,
    required this.child,
    this.useSafeArea = true,
    this.endDrawer,
    this.drawer,
    this.appBar,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: kcBackgroundColor,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    kcSecondaryColor.withValues(alpha: 0.3),
                    kcSecondaryColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          if (useSafeArea) SafeArea(child: child) else child,
        ],
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      body: content,
    );
  }
}
