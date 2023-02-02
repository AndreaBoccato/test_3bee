import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_3bee/core/instance_locator.dart';
import 'package:test_3bee/models/responses/apiaries_response.dart';

///
/// Essendoci solamente due chiamate api, per comodità racchiudo
/// tutto in un unico file
///
class CommonService {
  late Dio dio;

  CommonService() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://api.3bee.com/api/v1',
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> authenticateUser({required String email, required String password}) async {
    final response = await dio.post(
      '/auth/jwt/create',
      data: {
        'email': email,
        'password': password,
      },
    );

    log('JWT create response: ${response.data}');

    return response.data;
  }

  Future getApiaries({required int page}) async {
    final String accessToken = localCache.getAccessToken()!;
    final response = await dio.get(
      '/apiaries',
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
      queryParameters: {
        'page': page,
      },
    );

    final ApiariesResponse res = ApiariesResponse.fromJson(response.data);
  }
}
