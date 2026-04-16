import 'package:ecampusv2/app/data/models/dish_model.dart';
import 'package:ecampusv2/app/data/models/service_model.dart';

class Menu {
  String? sId;
  String? nom;
  String? date;
  Service? service;
  List<Dish>? plats;
  String? notes;
  int? iV;

  Menu({
    this.sId,
    this.nom,
    this.date,
    this.service,
    this.plats,
    this.notes,
    this.iV,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    date = json['date'];
    if (json['service'] != null) {
      if (json['service'] is String) {
        service = Service(sId: json['service']);
      } else {
        service = Service.fromJson(json['service']);
      }
    }
    plats = json['plats'] != null
        ? (json['plats'] as List).map((e) => Dish.fromJson(e)).toList()
        : [];
    notes = json['notes'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['date'] = date;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (plats != null) {
      data['plats'] = plats!.map((e) => e.toJson()).toList();
    }
    data['notes'] = notes;
    data['__v'] = iV;
    return data;
  }
}
