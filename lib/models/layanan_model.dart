class LayananModel {
  int? id;
  String? name;
  double? price;
  String? profilePhotoUrl;
  String? createdAt;

  LayananModel({
    this.id,
    this.name,
    this.price,
    this.profilePhotoUrl,
    this.createdAt,
  });

  LayananModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    profilePhotoUrl = json['profile_photo_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'profilePhotoUrl': profilePhotoUrl,
      'createdAt': createdAt,
    };
  }
}

class UninitializedMemberModel extends LayananModel {}
