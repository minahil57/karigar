import 'package:karigar/export.dart';

class ProvidersRepository {
  static Future<Map<String, dynamic>> getProviders(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await ApiProvider.provider.getAllProviders(
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final List<dynamic> providersData = response.data['data'];

        final List<ProviderData> providers = [];

        for (int i = 0; i < providersData.length; i++) {
          try {
            final item = providersData[i];

            providers.add(ProviderData.fromJson(item));
          } catch (e, stackTrace) {
            // 🔥 LOG EXACT ITEM THAT FAILED
            debugPrint("❌ JSON SERIALIZATION ERROR at index $i");
            debugPrint("❌ Failed item: ${providersData[i]}");
            debugPrint("❌ Error: $e");
            debugPrint("❌ StackTrace: $stackTrace");
          }
        }

        return {'data': providers, 'error': null};
      } else {
        debugPrint("❌ API ERROR: ${response.data}");

        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e, stackTrace) {
      debugPrint("❌ DIO ERROR: ${e.response?.data}");
      debugPrint("❌ MESSAGE: ${e.message}");
      debugPrint("❌ STACK: $stackTrace");

      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e, stackTrace) {
      debugPrint("❌ UNKNOWN ERROR: $e");
      debugPrint("❌ STACK: $stackTrace");

      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> getProfile({String? id}) async {
    log('Api function');

    try {
      final response = await ApiProvider.provider.getProfile(id!);

      log('Status Code: ${response.statusCode}');
      log('Raw Response: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final jsonData = response.data;

          log('JSON Type: ${jsonData.runtimeType}');
          log('JSON Data: $jsonData');

          final provider = ProviderData.fromJson(jsonData);

          log('Parsed Provider: ${provider.toJson()}');

          return {'data': provider, 'error': null};
        } catch (e, stackTrace) {
          log('JSON Parsing Error: $e');
          log('StackTrace: $stackTrace');

          return {'data': null, 'error': 'JSON Parsing Error: $e'};
        }
      } else {
        log('API Error: ${response.data}');

        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e, stackTrace) {
      log('Dio Error: ${e.message}');
      log('Dio Response: ${e.response?.data}');
      log('StackTrace: $stackTrace');

      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e, stackTrace) {
      log('Unexpected Error: $e');
      log('StackTrace: $stackTrace');

      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> getProviderBookings({String? id}) async {
    try {
      final response = await ApiProvider.provider.getProviderBookings(id!);

      if (response.statusCode == 200) {
        final List<dynamic> bookingsData = response.data['data'];

        final List<ServiceRequestModel> bookings = bookingsData
            .map((e) => ServiceRequestModel.fromJson(e))
            .toList();

        return {'data': bookings, 'error': null};
      } else {
        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e) {
      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await ApiProvider.provider.updateProfile(data);

      if (response.statusCode == 200) {
        return {'data': response.data, 'error': null};
      } else {
        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e) {
      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> getServices() async {
    try {
      final response = await ApiProvider.services.getAllServices();

      if (response.statusCode == 200) {
        final List<dynamic> servicesData = response.data ?? [];

        final List<ServiceModel> services = servicesData
            .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return {'data': services, 'error': null};
      } else {
        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e) {
      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> addProviderService(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await ApiProvider.services.addProviderService(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'data': response.data, 'error': null};
      } else {
        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e) {
      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<bool> updateBookingStatus(String id, String status) async {
    try {
      final response = await ApiProvider.provider.updateBookingStatus(
        id,
        status,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
