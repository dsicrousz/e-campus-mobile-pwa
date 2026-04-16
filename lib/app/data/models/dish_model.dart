import 'package:ecampusv2/app/data/models/service_model.dart';
import 'package:ecampusv2/app/data/models/ticket_model.dart';

class Dish {
  String? sId;
  String? nom;
  String? image;
  Service? service;
  Ticket? ticket;
  String? description;
  List<String>? ingredients;
  List<String>? allergenes;
  int? iV;

  Dish({
    this.sId,
    this.nom,
    this.image,
    this.service,
    this.ticket,
    this.description,
    this.ingredients,
    this.allergenes,
    this.iV,
  });

  Dish.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    image = json['image'];
    if (json['service'] != null) {
      if (json['service'] is String) {
        service = json['service'];
      } else {
        service = Service.fromJson(json['service']);
      }
    }
    if (json['ticket'] != null) {
      if (json['ticket'] is String) {
        ticket = Ticket(sId: json['ticket']);
      } else {
        ticket = Ticket.fromJson(json['ticket']);
      }
    }
    description = json['description'];
    ingredients = json['ingredients'] != null
        ? List<String>.from(json['ingredients'])
        : [];
    allergenes =
        json['allergenes'] != null ? List<String>.from(json['allergenes']) : [];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['image'] = image;
    if (service != null) {
      if (service is Service) {
        data['service'] = (service as Service).toJson();
      } else {
        data['service'] = service;
      }
    }
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    data['description'] = description;
    data['ingredients'] = ingredients;
    data['allergenes'] = allergenes;
    data['__v'] = iV;
    return data;
  }
}
