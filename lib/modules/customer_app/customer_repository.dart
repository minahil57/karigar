import 'package:karigar/export.dart';

class CustomerRepository {


  static Future<Map<String, dynamic>> getBookings() async {
    try {
      final response = await ApiProvider.customer.getBookings();

      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data['data'] as List<dynamic>).map((e) => ServiceRequestModel.fromJson(e)).toList();
        return {'data': data, 'error': null};
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
      final response = await ApiProvider.customer.updateProfile(data: data);

      if (response.statusCode == 200) {
        return {'data': response.data['data'], 'error': null};
      } else {
        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e) {
      return {
        'data': null,
        'error': e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }
}