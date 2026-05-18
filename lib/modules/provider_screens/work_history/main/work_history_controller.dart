import 'package:karigar/export.dart';

class WorkHistoryController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final List<ServiceRequestModel> _historyList = <ServiceRequestModel>[];
  List<ServiceRequestModel> get historyList => _historyList;

  set historyList(List<ServiceRequestModel> value) {
    _historyList.clear();
    _historyList.assignAll(value);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
   await  fetchWorkHistory();
  }

  Future<void> fetchWorkHistory() async {
    try {
      isLoading.value = true;
      historyList = dummyServiceRequests;

      final result = await ProvidersRepository.getProviderBookings(
        id: getUser()?.id.toString(),
      );

      if (result['error'] == null) {
        historyList = result['data'] ?? [];
      } else {
        historyList.clear();
      }
    } catch (e) {
      historyList.clear();
    } finally {
      
      isLoading.value = false;
    }
  }

  List<ServiceRequestModel> get filteredList {
    if (selectedTabIndex.value == 0) return historyList;
    if (selectedTabIndex.value == 1) {
      return historyList
          .where((e) => e.status.toLowerCase() == 'completed')
          .toList();
    }
    return historyList
        .where((e) => e.status.toLowerCase() == 'cancelled')
        .toList();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
