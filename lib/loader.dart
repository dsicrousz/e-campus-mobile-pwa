import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.loading});
  final RxBool loading;
  @override
  Widget build(BuildContext context) {
    return loading.isTrue
        ? const Center(
            child: GFLoader(
              type: GFLoaderType.custom,
              child: SpinKitFoldingCube(
                color: Colors.lightBlue,
                size: 50.0,
              ),
            ),
          )
        : const Text('');
  }
}
