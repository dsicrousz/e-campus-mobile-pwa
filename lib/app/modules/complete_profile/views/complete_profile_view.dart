import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/complete_profile_controller.dart';

class CompleteProfileView extends GetView<CompleteProfileController> {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Obx(() => Text(
              _getStepTitle(controller.currentStep.value),
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveUtils.fontSize(18),
                fontWeight: FontWeight.bold,
              ),
            )),
        centerTitle: true,
        leading: Obx(() => controller.currentStep.value > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: controller.previousStep,
              )
            : const SizedBox.shrink()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Obx(() => LinearProgressIndicator(
                  value: (controller.currentStep.value + 1) / 5,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                )),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                  child: Obx(() => _buildCurrentStep()),
                ),
              ),
            ),

            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Coordonnées';
      case 1:
        return 'Campus';
      case 2:
        return 'Contact d\'urgence';
      case 3:
        return 'Santé & Loisirs';
      case 4:
        return 'Confirmation';
      default:
        return 'Profil';
    }
  }

  Widget _buildCurrentStep() {
    switch (controller.currentStep.value) {
      case 0:
        return _buildStep1Coordonnees();
      case 1:
        return _buildStep2Campus();
      case 2:
        return _buildStep3ContactUrgence();
      case 3:
        return _buildStep4SanteLoisirs();
      case 4:
        return _buildStep5Confirmation();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Coordonnees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informations de contact'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Téléphone secondaire',
          hint: '+221 XX XXX XX XX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          onChanged: (v) => controller.telSecondaire.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Adresse',
          hint: 'Votre adresse complète',
          icon: Icons.home_outlined,
          onChanged: (v) => controller.adresse.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Quartier',
          hint: 'Votre quartier',
          icon: Icons.location_on_outlined,
          onChanged: (v) => controller.quartier.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Ville',
          hint: 'Votre ville',
          icon: Icons.location_city_outlined,
          onChanged: (v) => controller.ville.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Pays',
          hint: 'Votre pays',
          icon: Icons.flag_outlined,
          onChanged: (v) => controller.pays.value = v,
        ),
      ],
    );
  }

  Widget _buildStep2Campus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informations campus'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Campus',
          hint: 'Nom du campus',
          icon: Icons.school_outlined,
          onChanged: (v) => controller.campus.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildSwitchField(
          label: 'Résident sur le campus',
          value: controller.residentCampus,
        ),
        Obx(() => controller.residentCampus.value
            ? Column(
                children: [
                  SizedBox(height: ResponsiveUtils.hp(2)),
                  _buildTextField(
                    label: 'Pavillon',
                    hint: 'Numéro ou nom du pavillon',
                    icon: Icons.apartment_outlined,
                    onChanged: (v) => controller.pavillon.value = v,
                  ),
                  SizedBox(height: ResponsiveUtils.hp(2)),
                  _buildTextField(
                    label: 'Chambre',
                    hint: 'Numéro de chambre',
                    icon: Icons.door_front_door_outlined,
                    onChanged: (v) => controller.chambre.value = v,
                  ),
                ],
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildStep3ContactUrgence() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact d\'urgence'),
        SizedBox(height: ResponsiveUtils.hp(1)),
        Text(
          'Personne à contacter en cas d\'urgence',
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(13),
            color: AppTheme.textSecondaryColor,
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(3)),
        _buildTextField(
          label: 'Nom complet',
          hint: 'Nom du contact d\'urgence',
          icon: Icons.person_outline,
          onChanged: (v) => controller.contactUrgenceNom.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Lien de parenté',
          hint: 'Ex: Père, Mère, Tuteur...',
          icon: Icons.family_restroom_outlined,
          onChanged: (v) => controller.contactUrgenceLien.value = v,
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildTextField(
          label: 'Téléphone',
          hint: '+221 XX XXX XX XX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          onChanged: (v) => controller.contactUrgenceTel.value = v,
        ),
      ],
    );
  }

  Widget _buildStep4SanteLoisirs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informations médicales'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildDropdownField(
          label: 'Groupe sanguin',
          value: controller.groupeSanguin,
          items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
        ),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildChipInputField(
          label: 'Allergies',
          hint: 'Ajouter une allergie',
          items: controller.allergies,
          inputValue: controller.allergieInput,
          onAdd: controller.addAllergie,
          onRemove: controller.removeAllergie,
        ),
        SizedBox(height: ResponsiveUtils.hp(3)),
        _buildSectionTitle('Loisirs'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildChipInputField(
          label: 'Hobbies',
          hint: 'Ajouter un hobby',
          items: controller.hobbies,
          inputValue: controller.hobbyInput,
          onAdd: controller.addHobby,
          onRemove: controller.removeHobby,
        ),
      ],
    );
  }

  Widget _buildStep5Confirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Confirmation'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: ResponsiveUtils.wp(20),
                color: AppTheme.primaryColor,
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Vérifiez vos informations',
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                'Vous pouvez revenir en arrière pour modifier vos informations si nécessaire.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(14),
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(3)),
        Obx(() => CheckboxListTile(
              value: controller.accepteConditions.value,
              onChanged: (v) => controller.accepteConditions.value = v ?? false,
              title: Text(
                'J\'accepte les conditions d\'utilisation et la politique de confidentialité',
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(14),
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              activeColor: AppTheme.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            )),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(() {
        final isLastStep = controller.currentStep.value == 4;
        return SizedBox(
          width: double.infinity,
          height: ResponsiveUtils.hp(6),
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : isLastStep
                    ? controller.completeProfile
                    : controller.nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
              ),
            ),
            child: controller.isLoading.value
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: ResponsiveUtils.wp(5),
                  )
                : Text(
                    isLastStep ? 'Terminer' : 'Continuer',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(20),
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimaryColor,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(0.8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(15),
              color: AppTheme.textPrimaryColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
              prefixIcon: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: ResponsiveUtils.wp(5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(4),
                vertical: ResponsiveUtils.hp(1.8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchField({
    required String label,
    required RxBool value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(4),
        vertical: ResponsiveUtils.hp(1),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() => SwitchListTile(
            title: Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(15),
                color: AppTheme.textPrimaryColor,
              ),
            ),
            value: value.value,
            onChanged: (v) => value.value = v,
            activeColor: AppTheme.primaryColor,
            contentPadding: EdgeInsets.zero,
          )),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required RxString value,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(0.8)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: value.value.isEmpty ? null : value.value,
                  hint: Text(
                    'Sélectionner',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: ResponsiveUtils.fontSize(14),
                    ),
                  ),
                  items: items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => value.value = v ?? '',
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildChipInputField({
    required String label,
    required String hint,
    required RxList<String> items,
    required RxString inputValue,
    required VoidCallback onAdd,
    required Function(int) onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(0.8)),
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (v) => inputValue.value = v,
                      style: TextStyle(fontSize: ResponsiveUtils.fontSize(14)),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: ResponsiveUtils.fontSize(14),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle,
                        color: AppTheme.primaryColor,
                        size: ResponsiveUtils.wp(6)),
                    onPressed: onAdd,
                  ),
                ],
              ),
              Obx(() => items.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: ResponsiveUtils.hp(1)),
                      child: Wrap(
                        spacing: ResponsiveUtils.wp(2),
                        runSpacing: ResponsiveUtils.hp(0.5),
                        children: items
                            .asMap()
                            .entries
                            .map((e) => Chip(
                                  label: Text(e.value),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () => onRemove(e.key),
                                  backgroundColor: AppTheme.primaryColor
                                      .withValues(alpha: 0.1),
                                  labelStyle: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: ResponsiveUtils.fontSize(12),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ],
    );
  }
}
