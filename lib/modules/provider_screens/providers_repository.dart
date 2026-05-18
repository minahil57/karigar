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

        final List<ProviderData> providers = providersData
            .map((e) => ProviderData.fromJson(e))
            .toList();

        return {'data': providers, 'error': null};
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

  static Future<Map<String, dynamic>> getProfile({String? id}) async {
    log('Api function');
    try {
      final response = await ApiProvider.provider.getProfile(id!);

      if (response.statusCode == 200) {
        final provider = ProviderData.fromJson(response.data);

        return {'data': provider, 'error': null};
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

  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
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
  static Future<bool> updateBookingStatus(
    String id, String status) async {
    try {
      final response = await ApiProvider.provider.updateBookingStatus(id, status);

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
