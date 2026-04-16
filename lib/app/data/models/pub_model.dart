class Pub {
  String? sId;
  String? titre;
  String? description;
  String? image;
  String? debut;
  String? fin;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Pub(
      {this.sId,
      this.titre,
      this.description,
      this.debut,
      this.fin,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Pub.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titre = json['titre'];
    description = json['description'];
    debut = json['debut'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fin = json['fin'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['titre'] = titre;
    data['description'] = description;
    data['debut'] = debut;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['fin'] = fin;
    data['__v'] = iV;
    return data;
  }
}
