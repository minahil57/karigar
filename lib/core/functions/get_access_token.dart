import 'package:karigar/export.dart';

Future<String> getAccessToken() async =>
    await LocalStorage.getSecureData(LocalStorage.accessToken) ?? '';
