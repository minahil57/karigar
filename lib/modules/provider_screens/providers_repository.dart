import 'package:karigar/export.dart';

class ProvidersRepository {
  static Future<Map<String, dynamic>> getProviders(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      var response = await ApiProvider.provider.getAllProviders(
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final List<dynamic> providersData = response.data['data'];
        final providers =
            providersData.map((e) => ProviderData.fromJson(e)).toList();
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
        'error': e.response?.data['message'] ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }
}