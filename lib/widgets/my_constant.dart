import 'package:karigar/export.dart';

class MyConstantData {
  final double containerRadius;
  final double cardRadius;
  final double buttonRadius;


  MyConstantData({
    this.containerRadius = 4,
    this.cardRadius = 4,
    this.buttonRadius = 4,
  });
}

class MyConstant {
  static MyConstantData constant = MyConstantData();
}
