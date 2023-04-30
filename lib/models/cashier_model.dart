class CashierModel {
  int? id;
  String? memberId;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? password;
  String? profilePhotoUrl;
  String? roles;
  String? token;

  CashierModel({
    this.id,
    this.memberId,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.password,
    this.profilePhotoUrl,
    this.roles,
    this.token,
  });

  CashierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    profilePhotoUrl = json['profile_photo_url'];
    roles = json['roles'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'profilePhotoPath': profilePhotoUrl,
      'roles': roles,
      'token': token,
    };
  }
}
