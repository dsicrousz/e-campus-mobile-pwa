import 'dart:convert';
import 'package:ecampusv2/app/data/models/dish_model.dart';
import 'package:ecampusv2/app/data/models/menu_model.dart';
import 'package:ecampusv2/app/data/models/service_model.dart';
import 'package:ecampusv2/app/data/providers/menu_provider.dart';
import 'package:ecampusv2/app/data/providers/service_provider.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantsView extends StatefulWidget {
  const RestaurantsView({super.key});

  @override
  State<RestaurantsView> createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<RestaurantsView> {
  final ServiceProvider _serviceProvider = ServiceProvider();
  final MenuProvider _menuProvider = MenuProvider();
  List<Service> _restaurants = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final restaurants = await _serviceProvider.getByType('restaurant');
      setState(() {
        _restaurants = restaurants;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des restaurants';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.init(context);

    if (_isLoading) {
      return SizedBox(
        height: ResponsiveUtils.hp(25),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: ResponsiveUtils.hp(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: ResponsiveUtils.wp(10),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                _error!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              ElevatedButton(
                onPressed: _loadRestaurants,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }

    if (_restaurants.isEmpty) {
      return SizedBox(
        height: ResponsiveUtils.hp(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_outlined,
                color: Colors.grey,
                size: ResponsiveUtils.wp(12),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                'Aucun restaurant disponible',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(4),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Restaurants',
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              Text(
                '${_restaurants.length} disponible${_restaurants.length > 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(12),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.hp(22),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(3)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: ResponsiveUtils.wp(3),
              childAspectRatio: 1.1,
            ),
            itemCount: _restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantCard(_restaurants[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(Service restaurant) {
    return GestureDetector(
      onTap: () {
        _showRestaurantDetails(restaurant);
      },
      child: Container(
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
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -ResponsiveUtils.wp(5),
              right: -ResponsiveUtils.wp(5),
              child: Container(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.wp(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -ResponsiveUtils.wp(8),
              left: -ResponsiveUtils.wp(8),
              child: Container(
                width: ResponsiveUtils.wp(25),
                height: ResponsiveUtils.wp(25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(3)),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: ResponsiveUtils.wp(6),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(1.5)),
                  Text(
                    restaurant.nom ?? 'Restaurant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveUtils.fontSize(16),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                  if (restaurant.localisation != null)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: ResponsiveUtils.wp(3.5),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(1)),
                        Expanded(
                          child: Text(
                            restaurant.localisation!,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: ResponsiveUtils.fontSize(11),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(2.5),
                      vertical: ResponsiveUtils.hp(0.5),
                    ),
                    decoration: BoxDecoration(
                      color: restaurant.active == true
                          ? Colors.green.withValues(alpha: 0.9)
                          : Colors.red.withValues(alpha: 0.9),
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(3)),
                    ),
                    child: Text(
                      restaurant.active == true ? 'Actif' : 'hors service',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.fontSize(10),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRestaurantDetails(Service restaurant) {
    Get.bottomSheet(
      _RestaurantDetailsSheet(
        restaurant: restaurant,
        menuProvider: _menuProvider,
      ),
      isScrollControlled: true,
    );
  }
}

class _RestaurantDetailsSheet extends StatefulWidget {
  final Service restaurant;
  final MenuProvider menuProvider;

  const _RestaurantDetailsSheet({
    required this.restaurant,
    required this.menuProvider,
  });

  @override
  State<_RestaurantDetailsSheet> createState() =>
      _RestaurantDetailsSheetState();
}

class _RestaurantDetailsSheetState extends State<_RestaurantDetailsSheet> {
  Menu? _menuDuJour;
  bool _isLoadingMenu = true;
  String? _menuError;

  @override
  void initState() {
    super.initState();
    _loadMenuDuJour();
  }

  Future<void> _loadMenuDuJour() async {
    if (widget.restaurant.sId == null) return;
    try {
      final menu = await widget.menuProvider.findByDay(widget.restaurant.sId!);
      setState(() {
        _menuDuJour = menu;
        _isLoadingMenu = false;
      });
    } catch (e) {
      setState(() {
        _menuError = 'Aucun menu disponible';
        _isLoadingMenu = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveUtils.wp(5)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: ResponsiveUtils.wp(12),
                height: ResponsiveUtils.hp(0.5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(1)),
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    color: AppTheme.primaryColor,
                    size: ResponsiveUtils.wp(8),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.wp(4)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.nom ?? 'Restaurant',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(20),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(0.5)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(2),
                          vertical: ResponsiveUtils.hp(0.3),
                        ),
                        decoration: BoxDecoration(
                          color: widget.restaurant.active == true
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(ResponsiveUtils.wp(2)),
                        ),
                        child: Text(
                          widget.restaurant.active == true
                              ? 'Actif'
                              : 'hors service',
                          style: TextStyle(
                            color: widget.restaurant.active == true
                                ? Colors.green
                                : Colors.red,
                            fontSize: ResponsiveUtils.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.hp(3)),
            if (widget.restaurant.localisation != null) ...[
              _buildDetailRow(
                Icons.location_on_outlined,
                'Localisation',
                widget.restaurant.localisation!,
              ),
              SizedBox(height: ResponsiveUtils.hp(1.5)),
            ],
            if (widget.restaurant.description != null) ...[
              _buildDetailRow(
                Icons.info_outline,
                'Description',
                widget.restaurant.description!,
              ),
              SizedBox(height: ResponsiveUtils.hp(1.5)),
            ],
            SizedBox(height: ResponsiveUtils.hp(2)),
            _buildMenuDuJourSection(),
            SizedBox(height: ResponsiveUtils.hp(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDuJourSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.restaurant_menu,
              color: AppTheme.primaryColor,
              size: ResponsiveUtils.wp(5),
            ),
            SizedBox(width: ResponsiveUtils.wp(2)),
            Text(
              'Menu du jour',
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(16),
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveUtils.hp(1.5)),
        if (_isLoadingMenu)
          Center(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
              child: const CircularProgressIndicator(),
            ),
          )
        else if (_menuError != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.no_food,
                  color: Colors.grey,
                  size: ResponsiveUtils.wp(8),
                ),
                SizedBox(height: ResponsiveUtils.hp(1)),
                Text(
                  _menuError!,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ResponsiveUtils.fontSize(14),
                  ),
                ),
              ],
            ),
          )
        else if (_menuDuJour != null)
          _buildMenuContent(),
      ],
    );
  }

  Widget _buildMenuContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_menuDuJour!.nom != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withValues(alpha: 0.1),
                  AppTheme.primaryColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            ),
            child: Text(
              _menuDuJour!.nom!,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        SizedBox(height: ResponsiveUtils.hp(1.5)),
        if (_menuDuJour!.plats != null && _menuDuJour!.plats!.isNotEmpty)
          ...(_menuDuJour!.plats!.map((dish) => _buildDishCard(dish)).toList())
        else
          Text(
            'Aucun plat disponible',
            style: TextStyle(
              color: Colors.grey,
              fontSize: ResponsiveUtils.fontSize(14),
            ),
          ),
        if (_menuDuJour!.notes != null && _menuDuJour!.notes!.isNotEmpty) ...[
          SizedBox(height: ResponsiveUtils.hp(1.5)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
              border: Border.all(
                color: Colors.amber.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.amber[700],
                  size: ResponsiveUtils.wp(4),
                ),
                SizedBox(width: ResponsiveUtils.wp(2)),
                Expanded(
                  child: Text(
                    _menuDuJour!.notes!,
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: ResponsiveUtils.fontSize(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDishCard(Dish dish) {
    return GestureDetector(
      onTap: () => _showRatingDialog(dish),
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (dish.image != null && dish.image!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                    child: Image.network(
                      '${dish.image}',
                      width: ResponsiveUtils.wp(15),
                      height: ResponsiveUtils.wp(15),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: ResponsiveUtils.wp(15),
                        height: ResponsiveUtils.wp(15),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(ResponsiveUtils.wp(2)),
                        ),
                        child: Icon(
                          Icons.fastfood,
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(6),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: ResponsiveUtils.wp(15),
                    height: ResponsiveUtils.wp(15),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(2)),
                    ),
                    child: Icon(
                      Icons.fastfood,
                      color: AppTheme.primaryColor,
                      size: ResponsiveUtils.wp(6),
                    ),
                  ),
                SizedBox(width: ResponsiveUtils.wp(3)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.nom ?? 'Plat',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(14),
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      if (dish.ticket != null && dish.ticket!.nom != null) ...[
                        SizedBox(height: ResponsiveUtils.hp(0.3)),
                        Text(
                          dish.ticket!.nom!,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(12),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (dish.ticket != null && dish.ticket!.prix != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(2.5),
                      vertical: ResponsiveUtils.hp(0.5),
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(2)),
                    ),
                    child: Text(
                      '${dish.ticket!.prix} F',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.fontSize(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.hp(0.8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.amber,
                  size: ResponsiveUtils.wp(4),
                ),
                SizedBox(width: ResponsiveUtils.wp(1)),
                Text(
                  'Appuyez pour noter',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(11),
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(Dish dish) {
    final storage = GetStorage();
    final storedCompte = storage.read('ecampus_compte');
    if (storedCompte == null) {
      Get.snackbar(
        'Erreur',
        'Vous devez être connecté pour noter un plat',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    final compte = jsonDecode(storedCompte);
    final compteId = compte['_id'];
    if (compteId == null || dish.sId == null) return;

    Get.dialog(
      _DishRatingDialog(
        dish: dish,
        compteId: compteId,
        menuProvider: widget.menuProvider,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: ResponsiveUtils.wp(5),
        ),
        SizedBox(width: ResponsiveUtils.wp(3)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(12),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: ResponsiveUtils.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DishRatingDialog extends StatefulWidget {
  final Dish dish;
  final String compteId;
  final MenuProvider menuProvider;

  const _DishRatingDialog({
    required this.dish,
    required this.compteId,
    required this.menuProvider,
  });

  @override
  State<_DishRatingDialog> createState() => _DishRatingDialogState();
}

class _DishRatingDialogState extends State<_DishRatingDialog> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_selectedRating == 0) {
      Get.snackbar(
        'Attention',
        'Veuillez sélectionner une note',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final data = <String, dynamic>{
        'rating': _selectedRating,
      };
      if (_commentController.text.trim().isNotEmpty) {
        data['comment'] = _commentController.text.trim();
      }

      await widget.menuProvider.upsertDishRating(
        widget.compteId,
        widget.dish.sId!,
        data,
      );

      Get.back();
      Get.snackbar(
        'Succès',
        'Votre note a été enregistrée',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible d\'enregistrer votre note',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Noter ce plat',
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(18),
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            Text(
              widget.dish.nom ?? 'Plat',
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(14),
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => _selectedRating = starIndex),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(1),
                    ),
                    child: Icon(
                      starIndex <= _selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: ResponsiveUtils.wp(10),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            Text(
              _getRatingText(),
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(12),
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ajouter un commentaire (optionnel)',
                hintStyle: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(13),
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                  borderSide: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                  borderSide: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                  ),
                ),
                contentPadding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                    ),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ResponsiveUtils.fontSize(14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.wp(3)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitRating,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(2)),
                      ),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            width: ResponsiveUtils.wp(5),
                            height: ResponsiveUtils.wp(5),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Envoyer',
                            style: TextStyle(
                              color: Colors.white,
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
    );
  }

  String _getRatingText() {
    switch (_selectedRating) {
      case 1:
        return 'Très mauvais';
      case 2:
        return 'Mauvais';
      case 3:
        return 'Moyen';
      case 4:
        return 'Bon';
      case 5:
        return 'Excellent';
      default:
        return 'Sélectionnez une note';
    }
  }
}
