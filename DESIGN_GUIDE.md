# 📘 Guide d'Utilisation du Design System E-Campus

## 🎯 Introduction

Ce guide vous aidera à utiliser le design system moderne de l'application E-Campus pour créer des interfaces cohérentes et élégantes.

---

## 🚀 Démarrage Rapide

### 1. Importer les dépendances nécessaires

```dart
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/app/widgets/modern_components.dart';
```

### 2. Initialiser ResponsiveUtils dans votre vue

```dart
@override
Widget build(BuildContext context) {
  // TOUJOURS initialiser en premier
  ResponsiveUtils.init(context);
  
  return Scaffold(
    // Votre contenu ici
  );
}
```

---

## 🎨 Utilisation des Composants

### Carte Moderne

```dart
ModernComponents.modernCard(
  child: Column(
    children: [
      Text('Contenu de la carte'),
      // Autres widgets
    ],
  ),
  padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
  margin: EdgeInsets.symmetric(
    horizontal: ResponsiveUtils.wp(3),
    vertical: ResponsiveUtils.hp(2),
  ),
)
```

### Container avec Gradient

```dart
ModernComponents.gradientContainer(
  child: Text(
    'Texte sur gradient',
    style: TextStyle(color: Colors.white),
  ),
  padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
)
```

### Champ de Texte Moderne

```dart
ModernComponents.modernTextField(
  hintText: 'Entrez votre email',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {
    // Gérer le changement
  },
)
```

### Bouton Principal

```dart
ModernComponents.primaryButton(
  text: 'VALIDER',
  icon: Icons.check,
  onPressed: () {
    // Action du bouton
  },
)
```

### Bouton Secondaire

```dart
ModernComponents.secondaryButton(
  text: 'ANNULER',
  icon: Icons.close,
  onPressed: () {
    // Action du bouton
  },
)
```

### Badge

```dart
ModernComponents.badge(
  text: 'Nouveau',
  icon: Icons.star,
  backgroundColor: Colors.green.withValues(alpha: 0.1),
  textColor: Colors.green,
)
```

### Titre de Section

```dart
ModernComponents.sectionTitle(
  title: 'Mes Transactions',
  subtitle: 'Historique complet',
  icon: Icons.receipt_long,
)
```

### État Vide

```dart
ModernComponents.emptyState(
  message: 'Aucune transaction trouvée',
  icon: Icons.inbox_outlined,
  actionText: 'Actualiser',
  onActionPressed: () {
    // Action de rafraîchissement
  },
)
```

### Avatar avec Initiales

```dart
ModernComponents.avatarWithInitials(
  firstName: 'Jean',
  lastName: 'Dupont',
  imageUrl: 'https://example.com/avatar.jpg',
  radius: ResponsiveUtils.wp(10),
)
```

### Élément de Liste

```dart
ModernComponents.listTile(
  title: 'Paramètres',
  subtitle: 'Gérer vos préférences',
  leadingIcon: Icons.settings,
  trailing: Icon(Icons.arrow_forward_ios),
  onTap: () {
    // Navigation
  },
)
```

### Dialogue de Confirmation

```dart
final result = await ModernComponents.showConfirmDialog(
  context: context,
  title: 'Confirmer la suppression',
  message: 'Voulez-vous vraiment supprimer cet élément ?',
  icon: Icons.delete,
  iconColor: Colors.red,
  confirmText: 'Supprimer',
  cancelText: 'Annuler',
);

if (result == true) {
  // L'utilisateur a confirmé
}
```

---

## 📐 Système d'Espacement

### Espacement Horizontal (% de la largeur d'écran)

```dart
ResponsiveUtils.wp(2)   // Très petit (2%)
ResponsiveUtils.wp(3)   // Petit (3%)
ResponsiveUtils.wp(4)   // Standard (4%)
ResponsiveUtils.wp(5)   // Moyen (5%)
ResponsiveUtils.wp(8)   // Large (8%)
```

### Espacement Vertical (% de la hauteur d'écran)

```dart
ResponsiveUtils.hp(0.5) // Très petit
ResponsiveUtils.hp(1)   // Petit
ResponsiveUtils.hp(2)   // Standard
ResponsiveUtils.hp(3)   // Moyen
ResponsiveUtils.hp(4)   // Large
```

### Exemple d'utilisation

```dart
Container(
  padding: EdgeInsets.symmetric(
    horizontal: ResponsiveUtils.wp(5),
    vertical: ResponsiveUtils.hp(2),
  ),
  margin: EdgeInsets.only(
    top: ResponsiveUtils.hp(3),
    bottom: ResponsiveUtils.hp(1),
  ),
  child: // Contenu
)
```

---

## 🔤 Typographie

### Tailles de Police

```dart
Text(
  'Titre Principal',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(24),
    fontWeight: FontWeight.bold,
    color: AppTheme.textPrimaryColor,
  ),
)

Text(
  'Sous-titre',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(18),
    fontWeight: FontWeight.w600,
    color: AppTheme.textPrimaryColor,
  ),
)

Text(
  'Corps de texte',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(16),
    fontWeight: FontWeight.w400,
    color: AppTheme.textPrimaryColor,
  ),
)

Text(
  'Texte secondaire',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(14),
    color: AppTheme.textSecondaryColor,
  ),
)
```

---

## 🎨 Couleurs

### Couleurs Principales

```dart
AppTheme.primaryColor       // Couleur principale
AppTheme.secondaryColor     // Couleur secondaire
AppTheme.accentColor        // Couleur d'accent
AppTheme.backgroundColor    // Fond
```

### Couleurs de Texte

```dart
AppTheme.textPrimaryColor   // Texte principal (sombre)
AppTheme.textSecondaryColor // Texte secondaire (gris)
```

### Couleurs Sémantiques

```dart
Colors.green               // Succès
Colors.red                 // Erreur
Colors.blue                // Information
Colors.amber               // Avertissement
```

### Transparence

```dart
Colors.white.withValues(alpha: 0.1)   // 10% opacité
Colors.white.withValues(alpha: 0.5)   // 50% opacité
Colors.black.withValues(alpha: 0.05)  // 5% opacité (ombres)
```

---

## 🎭 Effets Visuels

### Ombres

```dart
// Ombre légère
boxShadow: [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 8,
    spreadRadius: 0,
    offset: const Offset(0, 2),
  ),
]

// Ombre moyenne
boxShadow: [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.1),
    blurRadius: 10,
    spreadRadius: 1,
    offset: const Offset(0, 5),
  ),
]
```

### Coins Arrondis

```dart
BorderRadius.circular(ResponsiveUtils.wp(2))  // Petit
BorderRadius.circular(ResponsiveUtils.wp(3))  // Standard
BorderRadius.circular(ResponsiveUtils.wp(4))  // Moyen
BorderRadius.circular(ResponsiveUtils.wp(6))  // Large
```

### Gradients

```dart
decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppTheme.primaryColor,
      AppTheme.primaryColor.withValues(alpha: 0.8),
    ],
  ),
)
```

---

## 📱 Structure d'une Vue Moderne

### Template de Base

```dart
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/app/widgets/modern_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaVueView extends GetView<MaVueController> {
  const MaVueView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation responsive
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      
      // AppBar moderne
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          'Titre de la Page',
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
      
      // Corps de la page
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(5),
              vertical: ResponsiveUtils.hp(2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre de section
                ModernComponents.sectionTitle(
                  title: 'Section Principale',
                  subtitle: 'Description de la section',
                  icon: Icons.star,
                ),
                
                SizedBox(height: ResponsiveUtils.hp(2)),
                
                // Carte moderne
                ModernComponents.modernCard(
                  child: Column(
                    children: [
                      Text('Contenu de la carte'),
                      // Autres widgets
                    ],
                  ),
                ),
                
                SizedBox(height: ResponsiveUtils.hp(2)),
                
                // Bouton d'action
                ModernComponents.primaryButton(
                  text: 'ACTION PRINCIPALE',
                  icon: Icons.check,
                  onPressed: () {
                    // Action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## ✅ Checklist pour Nouvelle Vue

Avant de finaliser une nouvelle vue, vérifiez :

- [ ] `ResponsiveUtils.init(context)` appelé au début du build
- [ ] AppBar avec `AppTheme.primaryColor`
- [ ] Toutes les dimensions utilisent `ResponsiveUtils.wp()` ou `hp()`
- [ ] Toutes les tailles de police utilisent `ResponsiveUtils.fontSize()`
- [ ] Ombres subtiles sur les cartes (`alpha: 0.05`)
- [ ] Coins arrondis cohérents
- [ ] Couleurs de la palette `AppTheme`
- [ ] `BouncingScrollPhysics()` pour le scroll
- [ ] États de chargement gérés
- [ ] États vides gérés
- [ ] Boutons avec feedback visuel
- [ ] Espacements cohérents

---

## 🎯 Exemples Pratiques

### Formulaire Moderne

```dart
Column(
  children: [
    ModernComponents.modernTextField(
      hintText: 'Nom complet',
      prefixIcon: Icons.person,
      onChanged: (value) => controller.name(value),
    ),
    SizedBox(height: ResponsiveUtils.hp(2)),
    ModernComponents.modernTextField(
      hintText: 'Email',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => controller.email(value),
    ),
    SizedBox(height: ResponsiveUtils.hp(3)),
    ModernComponents.primaryButton(
      text: 'SOUMETTRE',
      icon: Icons.send,
      onPressed: () => controller.submit(),
    ),
  ],
)
```

### Liste avec État Vide

```dart
Obx(() {
  if (controller.isLoading.value) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.primaryColor,
      ),
    );
  }
  
  if (controller.items.isEmpty) {
    return ModernComponents.emptyState(
      message: 'Aucun élément trouvé',
      icon: Icons.inbox_outlined,
      actionText: 'Actualiser',
      onActionPressed: () => controller.refresh(),
    );
  }
  
  return ListView.builder(
    itemCount: controller.items.length,
    itemBuilder: (context, index) {
      final item = controller.items[index];
      return ModernComponents.listTile(
        title: item.title,
        subtitle: item.subtitle,
        leadingIcon: Icons.star,
        onTap: () => controller.selectItem(item),
      );
    },
  );
})
```

---

## 🚨 Erreurs Courantes à Éviter

### ❌ Mauvais
```dart
// Dimensions en dur
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
)

// Taille de police fixe
Text(
  'Titre',
  style: TextStyle(fontSize: 24),
)
```

### ✅ Bon
```dart
// Dimensions responsives
Container(
  width: ResponsiveUtils.wp(50),
  height: ResponsiveUtils.hp(15),
  padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
)

// Taille de police responsive
Text(
  'Titre',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(24),
  ),
)
```

---

## 📚 Ressources

- **Design System** : `DESIGN_SYSTEM.md`
- **Composants** : `lib/app/widgets/modern_components.dart`
- **Thème** : `lib/app/utils/app_theme.dart`
- **Responsive** : `lib/app/utils/responsive_utils.dart`

---

## 💡 Conseils

1. **Toujours tester sur différentes tailles d'écran**
2. **Utiliser les composants existants avant d'en créer de nouveaux**
3. **Respecter la palette de couleurs**
4. **Garder les ombres subtiles**
5. **Privilégier la cohérence à l'originalité**

---

**Bon développement ! 🚀**
