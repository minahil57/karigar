import 'package:karigar/export.dart';

class ProfileModel {
  final String name;
  final String profession;
  final String profileImageUrl;
  final String rating;
  final String reviews;
  final bool isVerified;
  final String status;
  final String experience;
  final String memberSince;
  final String phone;
  final String email;
  final String serviceAreas;
  final String languages;
  final String aboutMe;
  final List<String> skills;
  final String jobsCompleted;
  final String successRate;
  final String avgRating;

  ProfileModel({
    required this.name,
    required this.profession,
    required this.profileImageUrl,
    required this.rating,
    required this.reviews,
    required this.isVerified,
    required this.status,
    required this.experience,
    required this.memberSince,
    required this.phone,
    required this.email,
    required this.serviceAreas,
    required this.languages,
    required this.aboutMe,
    required this.skills,
    required this.jobsCompleted,
    required this.successRate,
    required this.avgRating,
  });
}
