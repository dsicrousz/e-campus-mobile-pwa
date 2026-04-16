class PayementSubject {
  String? sId;
  String? nom;
  int? prix;
  Service? service;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PayementSubject(
      {this.sId,
      this.nom,
      this.prix,
      this.service,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PayementSubject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    prix = json['prix'];
    service =
        json['service'] != null ? Service?.fromJson(json['service']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['prix'] = prix;
    if (service != null) {
      data['service'] = service?.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Service {
  String? sId;
  String? nom;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Service({this.sId, this.nom, this.createdAt, this.updatedAt, this.iV});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nom = json['nom'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['nom'] = nom;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
