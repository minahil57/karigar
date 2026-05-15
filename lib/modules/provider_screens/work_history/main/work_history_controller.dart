import 'package:karigar/export.dart';
import '../model/work_history_model.dart';

class WorkHistoryController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final RxList<WorkHistoryModel> historyList = <WorkHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadHistoryData();
  }

  void _loadHistoryData() {
    // Mock data based on the provided design
    historyList.value = [
      WorkHistoryModel(
        serviceTitle: 'Plumbing Repair',
        description: 'Bathroom pipe leakage',
        location: 'Koramangala, Bengaluru',
        dateTime: '12 May 2025, 2:00 PM',
        price: '₹1,250',
        status: WorkStatus.completed,
        rating: 5.0,
      ),
      WorkHistoryModel(
        serviceTitle: 'Tap Installation',
        description: 'Kitchen tap replacement',
        location: 'HSR Layout, Bengaluru',
        dateTime: '10 May 2025, 11:30 AM',
        price: '₹850',
        status: WorkStatus.completed,
        rating: 4.9,
      ),
      WorkHistoryModel(
        serviceTitle: 'Water Heater Repair',
        description: 'Geyser not heating',
        location: 'Indiranagar, Bengaluru',
        dateTime: '08 May 2025, 4:00 PM',
        price: '₹1,100',
        status: WorkStatus.completed,
        rating: 5.0,
      ),
      WorkHistoryModel(
        serviceTitle: 'Drain Cleaning',
        description: 'Bathroom drain blocked',
        location: 'Jayanagar, Bengaluru',
        dateTime: '05 May 2025, 10:00 AM',
        price: '₹900',
        status: WorkStatus.completed,
        rating: 4.8,
      ),
    ];
  }

  List<WorkHistoryModel> get filteredList {
    if (selectedTabIndex.value == 0) return historyList;
    if (selectedTabIndex.value == 1) {
      return historyList
          .where((e) => e.status == WorkStatus.completed)
          .toList();
    }
    return historyList.where((e) => e.status == WorkStatus.cancelled).toList();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
