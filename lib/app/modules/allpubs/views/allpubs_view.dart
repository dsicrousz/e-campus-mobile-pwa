import 'package:ecampusv2/app/data/models/pub_model.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../controllers/allpubs_controller.dart';

class AllpubsView extends GetView<AllpubsController> {
  const AllpubsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.98),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          'Toutes les annonces',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: ResponsiveUtils.wp(6),
            ),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        } else if (controller.hasError.value) {
          return _buildErrorState();
        } else if (controller.allPubs.isEmpty) {
          return _buildEmptyState();
        } else {
          return _buildPubsList();
        }
      }),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
            color: AppTheme.primaryColor,
            size: ResponsiveUtils.wp(15),
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
          Text(
            'Chargement des annonces...',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: ResponsiveUtils.fontSize(16),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: ResponsiveUtils.wp(20),
              color: Colors.red.shade400,
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Text(
              'Impossible de charger les annonces',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(18),
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(14),
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(3)),
            ElevatedButton.icon(
              onPressed: () => controller.loadAllPubs(),
              icon: Icon(Icons.refresh_rounded),
              label: Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(6),
                  vertical: ResponsiveUtils.hp(1.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement_outlined,
            size: ResponsiveUtils.wp(20),
            color: Colors.grey.shade400,
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
          Text(
            'Aucune annonce disponible',
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(1)),
          Text(
            'Revenez plus tard pour voir les nouvelles annonces',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(14),
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(3)),
          ElevatedButton.icon(
            onPressed: () => controller.loadAllPubs(),
            icon: Icon(Icons.refresh_rounded),
            label: Text('Actualiser'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(6),
                vertical: ResponsiveUtils.hp(1.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPubsList() {
    return LiquidPullToRefresh(
      onRefresh: () => controller.loadAllPubs(),
      color: AppTheme.primaryColor,
      height: ResponsiveUtils.hp(5),
      backgroundColor: Colors.white,
      animSpeedFactor: 2.0,
      showChildOpacityTransition: false,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.wp(4),
          vertical: ResponsiveUtils.hp(2),
        ),
        itemCount: controller.filteredPubs.length,
        itemBuilder: (context, index) {
          final pub = controller.filteredPubs[index];
          return _buildPubCard(pub);
        },
      ),
    );
  }

  Widget _buildPubCard(Pub pub) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
        child: InkWell(
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
          onTap: () => Get.toNamed(Routes.PUBDESCRIPTION, arguments: pub),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de l'annonce
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.wp(4)),
                  topRight: Radius.circular(ResponsiveUtils.wp(4)),
                ),
                child: Image.network(
                  "$backUrl/uploads/pubs/${pub.image}",
                  fit: BoxFit.cover,
                  height: ResponsiveUtils.hp(20),
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: ResponsiveUtils.hp(20),
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade400,
                        size: ResponsiveUtils.wp(10),
                      ),
                    ),
                  ),
                ),
              ),
              // Contenu de l'annonce
              Padding(
                padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    Text(
                      pub.titre ?? 'Sans titre',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(1)),
                    // Description
                    if (pub.description != null)
                      Text(
                        pub.description!,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(14),
                          color: Colors.grey.shade700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: ResponsiveUtils.hp(1.5)),
                    // Date
                    if (pub.debut != null)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: ResponsiveUtils.wp(4),
                            color: AppTheme.primaryColor.withValues(alpha: 0.7),
                          ),
                          SizedBox(width: ResponsiveUtils.wp(2)),
                          Text(
                            'Depuis ${_formatDate(pub.debut!)}',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.fontSize(12),
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(date);
    } catch (e) {
      return dateStr;
    }
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    searchController.text = controller.searchQuery.value;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(3),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rechercher une annonce',
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Entrez un mot clé...',
                  prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.5),
                  ),
                ),
                onChanged: (value) {
                  // Mise à jour en temps réel
                  controller.updateSearchQuery(value);
                },
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: ResponsiveUtils.fontSize(14),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.wp(3)),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateSearchQuery(searchController.text);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(2)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(4),
                        vertical: ResponsiveUtils.hp(1),
                      ),
                    ),
                    child: Text('Rechercher'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
