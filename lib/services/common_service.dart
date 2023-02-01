import 'package:dio/dio.dart';

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

  Future authenticateUser({required String email, required String password}) async {
    final response = await dio.post(
      '/auth/jwt/create',
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
