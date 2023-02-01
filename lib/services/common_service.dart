import 'package:dio/dio.dart';

class CommonService {
  final String _baseUrl = 'https://api.3bee.com/api/v1';
  late Dio dio;

  CommonService() {
    dio = Dio();
  }

  Future authenticateUser({required String email, required String password}) async {
    final response = await dio.post(
      '$_baseUrl/auth/jwt/create',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error response from server');
    }
  }
}
