import 'package:karigar/export.dart';

class ProviderModel {
  final String name;
  final String profession;
  final String rating;
  final String jobsCompleted;
  final String jobsTrend;
  final String totalEarnings;
  final String earningsTrend;
  final String activeBooking;
  final String activeBookingTime;
  final String profileImageUrl;

  ProviderModel({
    required this.name,
    required this.profession,
    required this.rating,
    required this.jobsCompleted,
    required this.jobsTrend,
    required this.totalEarnings,
    required this.earningsTrend,
    required this.activeBooking,
    required this.activeBookingTime,
    required this.profileImageUrl,
  });
}
