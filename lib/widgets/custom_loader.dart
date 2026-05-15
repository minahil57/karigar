import 'package:karigar/export.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.height = 100, this.width = 100});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loader.json',
        width: height,
        height: width,
      ),
    );
  }
}
