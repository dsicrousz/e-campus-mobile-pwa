# 🎨 E-Campus - Design System

## Vue d'ensemble

Ce document décrit le système de design moderne et cohérent appliqué à toutes les vues de l'application E-Campus PWA Étudiant.

---

## 🎯 Principes de Design

### 1. **Clarté et Lisibilité**
- Hiérarchie visuelle claire avec des titres bien définis
- Espacement généreux entre les éléments
- Typographie cohérente et lisible

### 2. **Modernité**
- Coins arrondis (border radius)
- Ombres douces et subtiles
- Gradients élégants
- Animations fluides (BouncingScrollPhysics)

### 3. **Cohérence**
- Palette de couleurs unifiée via `AppTheme`
- Composants réutilisables
- Responsive design avec `ResponsiveUtils`

---

## 🎨 Palette de Couleurs

### Couleurs Principales
```dart
AppTheme.primaryColor       // Couleur principale de l'app
AppTheme.secondaryColor     // Couleur secondaire
AppTheme.accentColor        // Couleur d'accent
AppTheme.backgroundColor    // Fond de l'application
```

### Couleurs de Texte
```dart
AppTheme.textPrimaryColor   // Texte principal
AppTheme.textSecondaryColor // Texte secondaire
```

### Couleurs Sémantiques
```dart
Colors.green               // Succès, dépôts positifs
Colors.red                 // Erreur, retraits
Colors.blue                // Information
Colors.amber               // Avertissement
```

---

## 📐 Espacements

### Système d'Espacement Responsive
```dart
// Horizontal (% de la largeur)
ResponsiveUtils.wp(5)      // Padding standard horizontal
ResponsiveUtils.wp(3)      // Padding réduit
ResponsiveUtils.wp(8)      // Padding large

// Vertical (% de la hauteur)
ResponsiveUtils.hp(2)      // Padding standard vertical
ResponsiveUtils.hp(1)      // Padding réduit
ResponsiveUtils.hp(4)      // Padding large
```

---

## 🔤 Typographie

### Tailles de Police
```dart
ResponsiveUtils.fontSize(24)  // Titre principal
ResponsiveUtils.fontSize(18)  // Titre secondaire
ResponsiveUtils.fontSize(16)  // Corps de texte
ResponsiveUtils.fontSize(14)  // Texte secondaire
ResponsiveUtils.fontSize(12)  // Petit texte
```

### Poids de Police
```dart
FontWeight.bold      // Titres importants
FontWeight.w600      // Sous-titres
FontWeight.w500      // Texte normal accentué
FontWeight.w400      // Texte normal
```

---

## 🎭 Composants Réutilisables

### 1. **AppBar Moderne**
```dart
AppBar(
  backgroundColor: AppTheme.primaryColor,
  elevation: 0,
  title: Text(
    'Titre',
    style: TextStyle(
      color: Colors.white,
      fontSize: ResponsiveUtils.fontSize(18),
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
    onPressed: () => Get.back(),
  ),
)
```

### 2. **Carte avec Ombre**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        spreadRadius: 0,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: // Contenu
)
```

### 3. **Bouton Principal**
```dart
ElevatedButton(
  onPressed: onPressed,
  style: ElevatedButton.styleFrom(
    backgroundColor: AppTheme.primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    padding: EdgeInsets.symmetric(
      vertical: ResponsiveUtils.hp(2),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
    ),
  ),
  child: Text(
    'TEXTE BOUTON',
    style: TextStyle(
      fontSize: ResponsiveUtils.fontSize(15),
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
  ),
)
```

### 4. **Champ de Saisie Moderne**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
    border: Border.all(
      color: AppTheme.primaryColor.withValues(alpha: 0.3),
      width: 1.5,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Placeholder',
      prefixIcon: Icon(Icons.icon, color: AppTheme.primaryColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.hp(1.5),
        horizontal: ResponsiveUtils.wp(3),
      ),
    ),
  ),
)
```

### 5. **Gradient Container**
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppTheme.primaryColor,
        AppTheme.primaryColor.withValues(alpha: 0.8),
      ],
    ),
    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
  ),
  child: // Contenu
)
```

---

## 📱 Vues Implémentées

### ✅ Vues avec Design Moderne

1. **QrpageView** - Page QR Code de l'étudiant
   - Carte élégante avec gradient
   - Avatar avec initiales
   - Badge de sécurité
   - Instructions claires

2. **AcceuilView** - Page d'accueil
   - Section solde avec gradient
   - QR code intégré
   - Boutons d'action rapides
   - Liste des transactions récentes

3. **VirementView** - Page de transfert
   - Formulaire moderne
   - Champs de saisie stylisés
   - Bouton d'action proéminent

4. **AlltransactionsView** - Liste des transactions
   - Barre de recherche moderne
   - Cartes de transaction avec icônes colorées
   - Pull-to-refresh

5. **LoginView** - Page de connexion
   - QR code animé
   - Bottom sheet pour le code PIN
   - Design épuré avec gradient

6. **MenuScreenView** - Menu latéral
   - Gradient de fond
   - Photo de profil avec ombre
   - Éléments de menu interactifs
   - Dialogue de confirmation moderne

7. **AssistanceView** - Page d'assistance
   - Cartes de contact cliquables
   - Section FAQ
   - Icônes colorées

8. **OperationView** - Détails d'une transaction
   - En-tête avec gradient coloré
   - Sections de détails bien organisées
   - Récapitulatif visuel

9. **PasswordUpdateView** - Modification du code
   - Champs PIN stylisés
   - Animation de chargement
   - Bouton de validation proéminent

---

## 🎨 Effets Visuels

### Ombres (Box Shadows)
```dart
// Ombre légère
BoxShadow(
  color: Colors.black.withValues(alpha: 0.05),
  blurRadius: 8,
  spreadRadius: 0,
  offset: const Offset(0, 2),
)

// Ombre moyenne
BoxShadow(
  color: Colors.black.withValues(alpha: 0.1),
  blurRadius: 10,
  spreadRadius: 1,
  offset: const Offset(0, 5),
)
```

### Coins Arrondis
```dart
BorderRadius.circular(ResponsiveUtils.wp(3))  // Standard
BorderRadius.circular(ResponsiveUtils.wp(4))  // Moyen
BorderRadius.circular(ResponsiveUtils.wp(6))  // Large
```

### Transparence
```dart
Colors.white.withValues(alpha: 0.1)   // Très transparent
Colors.white.withValues(alpha: 0.15)  // Transparent
Colors.white.withValues(alpha: 0.5)   // Semi-transparent
Colors.white.withValues(alpha: 0.9)   // Presque opaque
```

---

## 🔄 Animations

### Physics
```dart
const BouncingScrollPhysics()        // Scroll avec rebond
const AlwaysScrollableScrollPhysics() // Toujours scrollable
```

### Pull to Refresh
```dart
LiquidPullToRefresh(
  color: AppTheme.primaryColor,
  animSpeedFactor: 2.0,
  backgroundColor: Colors.white,
  onRefresh: () async { /* Action */ },
  child: // Contenu
)
```

---

## 📊 États de Chargement

### Spinner Moderne
```dart
SpinKitDoubleBounce(
  color: AppTheme.primaryColor,
  size: ResponsiveUtils.wp(15),
)
```

### État Vide
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.icon,
      size: ResponsiveUtils.wp(20),
      color: Colors.grey.withValues(alpha: 0.5),
    ),
    SizedBox(height: ResponsiveUtils.hp(2)),
    Text(
      "Message d'état vide",
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(16),
        color: Colors.grey.withValues(alpha: 0.8),
      ),
    ),
  ],
)
```

---

## ✨ Bonnes Pratiques

### 1. **Responsive Design**
- Toujours utiliser `ResponsiveUtils` pour les dimensions
- Initialiser avec `ResponsiveUtils.init(context)` dans chaque vue

### 2. **Accessibilité**
- Contraste suffisant entre texte et fond
- Tailles de touche minimales (44x44 points)
- Labels descriptifs pour les icônes

### 3. **Performance**
- Utiliser `const` pour les widgets statiques
- Optimiser les images avec `fit` approprié
- Limiter les rebuilds avec `Obx()` ciblés

### 4. **Cohérence**
- Réutiliser les composants définis
- Respecter les espacements standards
- Utiliser la palette de couleurs définie

---

## 🎯 Checklist Design

Pour chaque nouvelle vue, vérifier :

- [ ] AppBar moderne avec `AppTheme.primaryColor`
- [ ] Utilisation de `ResponsiveUtils` pour toutes les dimensions
- [ ] Ombres subtiles sur les cartes
- [ ] Coins arrondis cohérents
- [ ] Typographie avec tailles et poids appropriés
- [ ] États de chargement et vides gérés
- [ ] Animations fluides (BouncingScrollPhysics)
- [ ] Palette de couleurs respectée
- [ ] Espacements cohérents
- [ ] Boutons avec feedback visuel

---

## 📝 Notes

- **Version du Design System** : 2.0.0
- **Dernière mise à jour** : Novembre 2025
- **Framework** : Flutter avec GetX
- **Responsive** : Basé sur ResponsiveUtils personnalisé

---

## 🚀 Évolutions Futures

- [ ] Mode sombre complet
- [ ] Animations de transition entre pages
- [ ] Micro-interactions supplémentaires
- [ ] Thèmes personnalisables
- [ ] Composants de formulaire avancés

---

**Développé avec ❤️ pour E-Campus**
