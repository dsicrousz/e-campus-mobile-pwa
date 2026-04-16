import 'package:get/get.dart';

class OperationController extends GetxController {

  final count = 0.obs;

  void increment() => count.value++;
}
