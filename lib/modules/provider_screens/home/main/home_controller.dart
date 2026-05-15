import 'package:karigar/export.dart';

class HomeController extends GetxController {
  late ProviderModel provider;
  List<ServiceRequestModel> serviceRequests = [];

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    provider = ProviderModel(
      name: 'Aarav Sharma',
      profession: 'Plumbing Specialist',
      rating: '4.9 (128)',
      jobsCompleted: '128',
      jobsTrend: '+12 this month',
      totalEarnings: '₹28,450',
      earningsTrend: '+18% this month',
      activeBooking: 'Today, 2:00 PM - Plumbing Repair',
      activeBookingTime: 'Today, 2:00 PM',
      profileImageUrl:
          'https://img.freepik.com/free-photo/handsome-young-man-with-new-haircut_651396-2815.jpg',
    );

    serviceRequests = [
      ServiceRequestModel(
        title: 'Plumbing Repair',
        subtitle: 'Kitchen pipe leakage',
        location: 'Koramangala, Bengaluru',
        distance: '2.4 km',
        price: '₹1,250',
        timeAgo: 'Requested 10m ago',
        preferredTime: 'Today, 2:00 PM',
      ),
      ServiceRequestModel(
        title: 'Electrical Installation',
        subtitle: 'Ceiling fan installation',
        location: 'HSR Layout, Bengaluru',
        distance: '3.1 km',
        price: '₹950',
        timeAgo: 'Requested 25m ago',
        preferredTime: 'Tomorrow, 11:00 AM',
      ),
    ];
  }
}
