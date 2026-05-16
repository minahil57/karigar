import 'package:karigar/export.dart';

class ServiceRequestModel {
  final String title;
  final String subtitle;
  final String location;
  final String distance;
  final String price;
  final String timeAgo;
  final String preferredTime;

  ServiceRequestModel({
    required this.title,
    required this.subtitle,
    required this.location,
    required this.distance,
    required this.price,
    required this.timeAgo,
    required this.preferredTime,
  });
}
