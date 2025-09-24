import 'api_paths.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() => _instance;

  ApiHelper._init();
  Dio dio = Dio(BaseOptions(
    baseUrl: ApiPaths.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<Response> postRequest(
      {required String endPoint,
      Map<String, dynamic>? data,
      bool isFormData = true}) async {
    return await dio.post(endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data);
  }

  Future<Response> getRequest(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    return await dio.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> putRequest(
      {required String endPoint,
      Map<String, dynamic>? data,
      bool isFormData = true}) async {
    return await dio.put(endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data);
  }

  Future<Response> deleteRequest(
      {required String endPoint, Map<String, dynamic>? data}) async {
    return await dio.delete(endPoint, data: data);
  }

  Future<Response> patchRequest(
      {required String endPoint,
      Map<String, dynamic>? data,
      bool isFormData = true}) async {
    return await dio.patch(endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data);
  }

  Future<Response> headRequest(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    return await dio.head(endPoint, queryParameters: queryParameters);
  }
}
