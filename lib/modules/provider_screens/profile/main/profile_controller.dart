import 'package:karigar/export.dart';

class ProfileController extends GetxController {
  late ProfileModel profile;

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  void _loadProfileData() {
    // Mock data based on the provided design
    profile = ProfileModel(
      name: 'Aarav Sharma',
      profession: 'Plumbing Specialist',
      profileImageUrl: 'https://i.pravatar.cc/300?img=12',
      rating: '4.9',
      reviews: '128 reviews',
      isVerified: true,
      status: 'Available for Work',
      experience: '6+ Years',
      memberSince: 'Jan 2023',
      phone: '+91 98765 43210',
      email: 'aarav.sharma@example.com',
      serviceAreas: 'Bengaluru, Karnataka',
      languages: 'English, Hindi, Kannada',
      aboutMe: 'Experienced plumbing specialist providing quality and reliable plumbing services with a focus on customer satisfaction.',
      skills: ['Pipe Repair', 'Leak Detection', 'Tap Installation', 'Drain Cleaning', 'Water Heater Repair'],
      jobsCompleted: '128',
      successRate: '98%',
      avgRating: '4.9',
    );
  }
}
