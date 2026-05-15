import 'package:karigar/export.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFD9E9FF), // Soft faded blue
              Colors.white,       // To white
            ],
            stops: [0.0, 0.5],     // Concentrated at the top right
          ),
        ),
        child: child,
      ),
    );
  }
}
