import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pub_controller.dart';

class PubView extends GetView<PubController> {
  const PubView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);
    
    return Obx(
      () => controller.pages.isNotEmpty
          ? Container(
              margin: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.hp(2),
                horizontal: ResponsiveUtils.wp(2),
              ),
              child: Column(
                children: [
                  // Titre de la section
                  Container(
                    margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.campaign_rounded,
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(5),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(2)),
                        Text(
                          "Annonces",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(16),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        // Bouton voir toutes les annonces
                        TextButton.icon(
                          onPressed: () => Get.toNamed('/allpubs'),
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            size: ResponsiveUtils.wp(4),
                            color: AppTheme.primaryColor,
                          ),
                          label: Text(
                            "Voir tout",
                            style: TextStyle(
                              fontSize: ResponsiveUtils.fontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(3),
                              vertical: ResponsiveUtils.hp(0.5),
                            ),
                            foregroundColor: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Carousel avec ombre
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CarouselSlider(
                      items: controller.pages.map((page) {
                        // Ajouter un container avec des coins arrondis autour de chaque élément
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(1)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: page,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: ResponsiveUtils.hp(18),
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  
                  // Indicateurs de page simplifiés
                  if (controller.pages.length > 1)
                    Container(
                      margin: EdgeInsets.only(top: ResponsiveUtils.hp(1.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.pages.length,
                          (index) => Container(
                            width: ResponsiveUtils.wp(2),
                            height: ResponsiveUtils.hp(1),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(alpha: index == 0 ? 1.0 : 0.3),
                              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(1)),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : const SizedBox(height: 5),
    );
  }
}
