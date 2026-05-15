import 'package:karigar/export.dart';

enum WorkStatus { completed, cancelled }

class WorkHistoryModel {
  final String serviceTitle;
  final String description;
  final String location;
  final String dateTime;
  final String price;
  final WorkStatus status;
  final double rating;


  WorkHistoryModel({
    required this.serviceTitle,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.rating,

  });
}
