import 'package:dio/dio.dart';
import 'package:test_3bee/core/utils/dio_utils.dart';
import 'package:test_3bee/models/responses/apiaries_response.dart';

class ApiaryService {
  late Dio dio;

  ApiaryService() {
    dio = DioUtils.initApiClient();
  }

  Future<ApiariesResponse> getApiaries({required int page}) async {
    final response = await dio.get(
      '/apiaries',
      queryParameters: {
        'page': page,
      },
    );

    final ApiariesResponse apiariesResponse = ApiariesResponse.fromJson(response.data);
    return apiariesResponse;
  }
}
