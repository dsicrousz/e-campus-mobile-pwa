import 'package:ecampusv2/app/data/models/pub_model.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pubdescription_controller.dart';

class PubdescriptionView extends GetView<PubdescriptionController> {
  PubdescriptionView({super.key});
  final Pub arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.97),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          arg.titre!,
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtils.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: ResponsiveUtils.wp(5),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(4),
                vertical: ResponsiveUtils.hp(2),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête avec titre et date
                    Container(
                      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              arg.titre!,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(22),
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                          ),
                          if (arg.debut != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(3),
                                vertical: ResponsiveUtils.hp(0.5),
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(5)),
                              ),
                              child: Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(arg.debut!)),
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.fontSize(12),
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Image de la publicité
                    Container(
                      height: ResponsiveUtils.hp(40),
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(2)),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(4)),
                        child: Image.network(
                          "$backUrl/uploads/pubs/${arg.image!}",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: AppTheme.primaryColor,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.withValues(alpha: 0.2),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_rounded,
                                  size: ResponsiveUtils.wp(15),
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Description
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(16),
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            arg.description!,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.fontSize(14),
                              color: AppTheme.textPrimaryColor
                                  .withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
