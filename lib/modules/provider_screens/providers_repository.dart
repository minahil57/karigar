import 'package:karigar/export.dart';

class ProvidersRepository {
  static Future<Map<String, dynamic>> getProviders(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      debugPrint('========== GET PROVIDERS API ==========');
      debugPrint('Query Params: $queryParameters');

      final response = await ApiProvider.provider.getAllProviders(
        queryParameters: queryParameters,
      );

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Raw Response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> providersData = response.data['data'];

        debugPrint('Providers Count: ${providersData.length}');

        final List<ProviderData> providers = [];

        for (int i = 0; i < providersData.length; i++) {
          try {
            debugPrint('---------- Parsing Provider [$i] ----------');
            debugPrint('Provider JSON: ${providersData[i]}');

            final provider = ProviderData.fromJson(providersData[i]);

            providers.add(provider);

            debugPrint('Provider Parsed Successfully: ${provider.id}');
          } catch (e, stackTrace) {
            debugPrint('❌ Error Parsing Provider at index $i');
            debugPrint('❌ Provider Data: ${providersData[i]}');
            debugPrint('❌ Error: $e');
            debugPrint('❌ StackTrace: $stackTrace');
          }
        }

        debugPrint('========== END GET PROVIDERS ==========');

        return {'data': providers, 'error': null};
      } else {
        debugPrint('❌ API Error: ${response.data['message']}');

        return {
          'data': null,
          'error': response.data['message'] ?? 'Something went wrong',
        };
      }
    } on DioException catch (e, stackTrace) {
      debugPrint('❌ Dio Exception');
      debugPrint('❌ Message: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');
      debugPrint('❌ StackTrace: $stackTrace');

      return {
        'data': null,
        'error':
            e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      };
    } catch (e, stackTrace) {
      debugPrint('❌ Unexpected Exception');
      debugPrint('❌ Error: $e');
      debugPrint('❌ StackTrace: $stackTrace');

      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> getProfile({String? id}) async {
    try {
      var response = await ApiProvider.provider.getProfile(id!);
      if (response.statusCode == 200) {
        final provider = ProviderData.fromJson(response.data['data']);
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
        'error': e.response?.data['message'] ?? 'Something went wrong',
      };
    } catch (e) {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }
}
