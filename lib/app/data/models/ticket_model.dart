class Ticket {
  String? sId;
  String? nom;
  int? prix;
  String? description;
  bool? active;
  int? iV;

  Ticket({
    this.sId,
    this.nom,
    this.prix,
    this.description,
    this.active,
    this.iV,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    prix = json['prix'];
    description = json['description'];
    active = json['active'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['prix'] = prix;
    data['description'] = description;
    data['active'] = active;
    data['__v'] = iV;
    return data;
  }
}
