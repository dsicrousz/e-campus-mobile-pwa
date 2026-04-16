import 'package:ecampusv2/app/data/authrequest.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = backUrl;
  }

  Future<AuthRequest?> register(Map<String, String> auth) async {
    final response = await post("$backUrl/user", auth);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
    return AuthRequest.fromJson(response.body['data']);
  }

  Future<AuthRequest?> login(Map<String, String> auth) async {
    final response = await post("$backUrl/user/login", auth);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
    return AuthRequest.fromJson(response.body['data']);
  }
}
