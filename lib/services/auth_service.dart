import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_3bee/core/instance_locator.dart';

class AuthService {
  late Dio dio;

  AuthService() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://api.3bee.com/api/v1',
    );
    dio = Dio(options);
  }

  Future<void> _saveTokens(Map<String, dynamic> responseData) async {
    final String access = responseData['access'];
    final String refresh = responseData['refresh'];

    await localCache.setAccessToken(access);
    await localCache.setRefreshToken(refresh);
  }

  Future<void> authenticateUser({required String email, required String password}) async {
    final response = await dio.post(
      '/auth/jwt/create',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error from server: ${response.statusCode}');
    }

    log('JWT create response: ${response.data}');

    final Map<String, dynamic> responseData = response.data;
    await _saveTokens(responseData);
  }

  Future<void> refreshUserToken({required String refreshToken}) async {
    final response = await dio.post(
      "/auth/jwt/refresh",
      data: {
        'refresh': refreshToken,
      },
    );

    log('JWT refresh response: ${response.data}');

    final Map<String, dynamic> responseData = response.data;
    await _saveTokens(responseData);
  }
}
