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
                  value: (controller.currentStep.value + 1) / 3,
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
        return 'Informations';
      case 1:
        return 'Loisirs';
      case 2:
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
        return _buildStep2Loisirs();
      case 2:
        return _buildStep3Confirmation();
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
      ],
    );
  }

  Widget _buildStep2Loisirs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Loisirs'),
        SizedBox(height: ResponsiveUtils.hp(2)),
        _buildChipInputField(
          label: 'Hobbies',
          hint: 'Ajouter un hobby (ex: Lecture, Sport, Musique)',
          items: controller.hobbies,
          inputValue: controller.hobbyInput,
          onAdd: controller.addHobby,
          onRemove: controller.removeHobby,
        ),
      ],
    );
  }

  Widget _buildStep3Confirmation() {
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
        final isLastStep = controller.currentStep.value == 2;
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
