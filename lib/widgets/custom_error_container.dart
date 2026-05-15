import 'package:karigar/export.dart';

class CustomErrorContainer extends StatelessWidget {
  const CustomErrorContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: const Center(child: Icon(Icons.error, color: Colors.red)),
    );
  }
}
