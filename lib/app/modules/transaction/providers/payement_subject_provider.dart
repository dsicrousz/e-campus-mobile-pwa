import 'package:get/get.dart';

import '../payement_subject_model.dart';

class PayementSubjectProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PayementSubject.fromJson(map);
      if (map is List){
        return map.map((item) => PayementSubject.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PayementSubject?> getPayementSubject(int id) async {
    final response = await get('payementsubject/$id');
    return response.body;
  }

  Future<Response<PayementSubject>> postPayementSubject(
          PayementSubject payementsubject) async =>
      await post('payementsubject', payementsubject);
  Future<Response> deletePayementSubject(int id) async =>
      await delete('payementsubject/$id');
}
