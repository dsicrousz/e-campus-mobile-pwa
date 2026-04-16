import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;
import '../operation_model.dart';

class OperationProvider {
  GetStorage storage = GetStorage();
  final dio = d.Dio();

  OperationProvider() {
    dio.options.baseUrl = backUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.sendTimeout = const Duration(seconds: 10);
    dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    dio.interceptors.add(
      d.InterceptorsWrapper(
        onRequest:
            (d.RequestOptions options, d.RequestInterceptorHandler handler) {
          var token = storage.read('e_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse:
            (d.Response response, d.ResponseInterceptorHandler handler) {
          if (response.statusCode == 440 ||
              response.statusCode == 401 ||
              response.statusCode == 403) {
            storage.remove('ecampus_compte');
            Get.offAndToNamed(Routes.LOGIN);
          }
          return handler.next(response);
        },
        onError: (d.DioException error, d.ErrorInterceptorHandler handler) {
          final status = error.response?.statusCode;
          if (status == 440 || status == 401 || status == 403) {
            storage.remove('ecampus_compte');
            Get.offAndToNamed(Routes.LOGIN);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool?> virement(String idFrom, String idTo, int montant) async {
    Map<String, dynamic> data = {
      'id_from': idFrom,
      'id_to': idTo,
      'montant': montant
    };
    final response = await dio.post('/operation/virement', data: data);
    if (response.statusCode != 201) {
      throw Error();
    }
    return response.data == "true";
  }

  Future<List<Operation?>> getLatestOperations(String id) async {
    final response = await dio.get('/operation/compte/latest/$id');
    List<dynamic> body = response.data;
    return body.map((b) => Operation.fromJson(b)).toList();
  }

  Future<List<Operation?>> getOperations(String id) async {
    final response = await dio.get('/operation/compte/$id');
    List<dynamic> body = response.data;
    return body.map((b) => Operation.fromJson(b)).toList();
  }
}
