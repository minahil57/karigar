import 'package:karigar/export.dart';

class CustomLayout extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;

  const CustomLayout({super.key, required this.child, this.useSafeArea = true});

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            kcSecondaryColor.withValues(alpha: 0.2),
            kcSecondaryColor.withValues(alpha: 0.05),
            kcSecondaryColor.withValues(alpha: 0),
          ],
        ),
      ),
      child: child,
    );

    return Scaffold(resizeToAvoidBottomInset: true, body: content);
  }
}
