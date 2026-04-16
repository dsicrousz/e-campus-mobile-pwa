class Service {
  String? sId;
  String? nom;
  String? typeService;
  bool? active;
  String? localisation;
  String? description;
  int? iV;

  Service({
    this.sId,
    this.nom,
    this.typeService,
    this.active,
    this.localisation,
    this.description,
    this.iV,
  });

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    typeService = json['typeService'];

    active = json['active'];
    localisation = json['localisation'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['typeService'] = typeService;
    data['active'] = active;
    data['localisation'] = localisation;
    data['description'] = description;
    data['__v'] = iV;
    return data;
  }
}
