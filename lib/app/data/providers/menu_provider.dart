import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;

import '../models/menu_model.dart';

class MenuProvider {
  GetStorage storage = GetStorage();
  final dio = d.Dio();

  MenuProvider() {
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

  Future<Menu?> findOne(String id) async {
    final response = await dio.get('$backUrl/menus/$id');
    if (response.statusCode != 200) {
      throw Error();
    }
    return Menu.fromJson(response.data);
  }

  Future<List<Menu>> getMenuByRestaurant(String restaurantId) async {
    final response = await dio.get('$backUrl/menus/restaurant/$restaurantId');
    if (response.statusCode != 200) {
      throw Error();
    }
    return (response.data as List).map((e) => Menu.fromJson(e)).toList();
  }

  Future<Menu?> findByDay(String restaurantId) async {
    final response = await dio.get('$backUrl/menus/day/$restaurantId');
    if (response.statusCode != 200) {
      throw Error();
    }
    return Menu.fromJson(response.data);
  }

  Future<Map<String, dynamic>> upsertDishRating(
      String compteId, String dishId, Map<String, dynamic> data) async {
    final response = await dio.post(
      '$backUrl/menus/plats/$compteId/$dishId/ratings',
      data: data,
    );
    if (response.statusCode != 201) {
      throw Error();
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getDishRatingSummary(
      String compteId, String dishId) async {
    final response = await dio.get(
      '$backUrl/menus/plats/$compteId/$dishId/ratings/summary',
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    return response.data;
  }
}
