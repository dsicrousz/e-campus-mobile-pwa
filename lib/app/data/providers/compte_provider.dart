import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;

import '../models/compte_model.dart';

class CompteProvider {
  GetStorage storage = GetStorage();
  final dio = d.Dio();

  CompteProvider() {
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

  Future<Compte?> getCompte(String code, String pass) async {
    Map<String, String> data = {'code': code, 'password': pass};
    final response = await dio.post('$backUrl/compte/login', data: data);
    if (response.statusCode != 201) {
      throw Error();
    }
    storage.write('e_token', response.data['token']);
    return Compte.fromJson(response.data['compte']);
  }

  Future<Compte?> getCompteWithNcs(String code, String pass) async {
    Map<String, String> data = {'code': code, 'password': pass};
    final response = await dio.post('$backUrl/compte/loginwithncs', data: data);
    if (response.statusCode != 201) {
      throw Error();
    }
    storage.write('e_token', response.data['token']);
    return Compte.fromJson(response.data['compte']);
  }

  Future<Compte?> getCompteByNcs(String ncs) async {
    final response = await dio.get('$backUrl/compte/ncs/$ncs');
    if (response.statusCode != 200) {
      throw Error();
    }
    return Compte.fromJson(response.data);
  }

  Future<Compte?> changePassword(
      String id, String oldPass, String password) async {
    Map<String, String> data = {'oldPass': oldPass, 'password': password};
    final response =
        await dio.post('$backUrl/compte/changepassword/$id', data: data);
    if (response.statusCode != 201) {
      throw Error();
    }
    return Compte.fromJson(response.data);
  }

  Future<bool> passMath(String id, String password) async {
    Map<String, String> data = {'password': password};
    final response =
        await dio.post('$backUrl/compte/passmatch/$id', data: data);
    if (response.statusCode != 201) {
      throw Error();
    }
    return response.data == "true";
  }

  Future<bool> signalerPerteCarte(String id, bool estPerdu) async {
    Map<String, dynamic> data = {'est_perdu': estPerdu};
    final response = await dio.patch('$backUrl/compte/$id', data: data);
    if (response.statusCode != 200) {
      throw Error();
    }
    return response.data == "true";
  }

  Future<bool> completeProfile(String id, Map<String, dynamic> data) async {
    final response =
        await dio.patch('$backUrl/etudiant/$id/profile', data: data);
    if (response.statusCode != 200) {
      throw Error();
    }
    return response.data == "true";
  }

  Future<Compte?> load(String id) async {
    final response = await dio.get('$backUrl/compte/$id');
    return Compte.fromJson(response.data);
  }
}
