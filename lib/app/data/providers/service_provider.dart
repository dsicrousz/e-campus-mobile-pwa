import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;

import '../models/service_model.dart';

class ServiceProvider {
  GetStorage storage = GetStorage();
  final dio = d.Dio();

  ServiceProvider() {
    dio.interceptors.add(
      d.InterceptorsWrapper(
        onRequest:
            (d.RequestOptions options, d.RequestInterceptorHandler handler) {
          var token = storage.read('e_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse:
            (d.Response response, d.ResponseInterceptorHandler handler) {
          if (response.statusCode == 440) {
            storage.remove('ecampus_compte');
            Get.offAndToNamed(Routes.LOGIN);
          }
          return handler.next(response);
        },
        onError: (d.DioException error, d.ErrorInterceptorHandler handler) {
          if (error.response!.statusCode == 440) {
            storage.remove('ecampus_compte');
            Get.offAndToNamed(Routes.LOGIN);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Service?> findOne(String id) async {
    final response = await dio.get('$backUrl/service/$id');
    if (response.statusCode != 200) {
      throw Error();
    }
    return Service.fromJson(response.data);
  }

  Future<List<Service>> getByType(String type) async {
    final response = await dio.get('$backUrl/service/bytype/$type');
    if (response.statusCode != 200) {
      throw Error();
    }
    return (response.data as List).map((e) => Service.fromJson(e)).toList();
  }
}
