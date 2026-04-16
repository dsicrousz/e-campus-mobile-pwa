import 'package:ecampusv2/app/modules/drawerPage/controllers/drawer_page_controller.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/env.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MenuScreenView extends GetView<DrawerPageController> {
  const MenuScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryColor.withValues(alpha: 0.85),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: ResponsiveUtils.hp(3)),
              
              // En-tête du profil
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(5),
                  vertical: ResponsiveUtils.hp(2),
                ),
                child: Row(
                  children: [
                    Text(
                      "E-Campus",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.fontSize(22),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: ResponsiveUtils.wp(6),
                      ),
                      onPressed: () => controller.toggleDrawer(),
                    )
                  ],
                ),
              ),
              
              SizedBox(height: ResponsiveUtils.hp(2)),
              
              // Photo de profil avec effet d'ombre
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: ResponsiveUtils.wp(15),
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    '$profilUrl/${controller.currentCompte.etudiant?.avatar}',
                  ),
                  onForegroundImageError: (exception, stackTrace) => {},
                  child: Icon(
                    Icons.person,
                    size: ResponsiveUtils.wp(15),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              
              SizedBox(height: ResponsiveUtils.hp(2)),
              
              // Informations utilisateur
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(6)),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(5),
                  vertical: ResponsiveUtils.hp(2),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.currentCompte.etudiant?.prenom ?? ''} ${controller.currentCompte.etudiant?.nom ?? ''}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.fontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(0.5)),
                    Text(
                      controller.currentCompte.etudiant?.ncs ?? '#####',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: ResponsiveUtils.fontSize(14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: ResponsiveUtils.hp(4)),
              
              // Menu items
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.phone_in_talk_rounded,
                        title: 'Contacter l\'assistance',
                        onTap: () => Get.toNamed(Routes.ASSISTANCE),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(1.5)),
                      _buildMenuItem(
                        icon: Icons.lock_outline_rounded,
                        title: 'Modifier votre code secret',
                        onTap: () => Get.toNamed(Routes.PASSWORD_UPDATE),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(1.5)),
                      _buildMenuItem(
                        icon: Icons.logout_rounded,
                        title: 'Se déconnecter',
                        isLogout: true,
                        onTap: () => _showLogoutConfirmation(),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Version de l'application
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                child: Text(
                  "Version 2.0.0",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: ResponsiveUtils.fontSize(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget pour un élément de menu
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isLogout
            ? Colors.red.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
          splashColor: Colors.white.withValues(alpha: 0.1),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(5),
              vertical: ResponsiveUtils.hp(2),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout ? Colors.red.shade300 : Colors.white,
                  size: ResponsiveUtils.wp(6),
                ),
                SizedBox(width: ResponsiveUtils.wp(4)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isLogout ? Colors.red.shade300 : Colors.white,
                      fontSize: ResponsiveUtils.fontSize(15),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isLogout ? Colors.red.shade300 : Colors.white.withValues(alpha: 0.7),
                  size: ResponsiveUtils.wp(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Dialogue de confirmation pour la déconnexion
  void _showLogoutConfirmation() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.red,
                size: ResponsiveUtils.wp(15),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                "Voulez-vous vraiment vous déconnecter ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(15),
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Bouton Annuler
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Annuler",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(14),
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Bouton Confirmer
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade400,
                          Colors.red.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () => controller.logout(),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(5),
                          vertical: ResponsiveUtils.hp(1),
                        ),
                      ),
                      child: Text(
                        "Confirmer",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
