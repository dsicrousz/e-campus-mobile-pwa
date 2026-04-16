import 'package:ecampusv2/app/data/providers/pub_provider.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PubController extends GetxController {
  PubProvider pubProvider = PubProvider();
  var pages = <Widget>[].obs;
  var currentPubIndex = 0.obs;

  @override
  onInit() {
    super.onInit();
    load();
  }

  void load() {
    pubProvider.load().then((value) {
      pages(value
          .map((p) => Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.PUBDESCRIPTION, arguments: p),
                  child: Stack(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(4)),
                        child: Image.network(
                          "$backUrl/uploads/pubs/${p?.image}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey.shade400,
                              size: ResponsiveUtils.wp(10),
                            ),
                          ),
                        ),
                      ),
                      // Overlay gradient
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.wp(4)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Titre
                      if (p?.titre != null)
                        Positioned(
                          bottom: ResponsiveUtils.hp(2),
                          left: ResponsiveUtils.wp(3),
                          right: ResponsiveUtils.wp(3),
                          child: Text(
                            p?.titre ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ResponsiveUtils.fontSize(14),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ))
          .toList());
    },
        onError: (err) => Get.snackbar(
            'pub status', 'Error lors du rafraichissement !',
            colorText: Colors.white, backgroundColor: Colors.red));
  }
}
