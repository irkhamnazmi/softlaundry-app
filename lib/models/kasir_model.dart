import 'package:intl/intl.dart';

class KasirModel {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? password;
  String? profilePhotoUrl;
  String? roles;
  String? token;
  String? createdAt;
  DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy, hh:mm:ss', 'id');

  KasirModel({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.password,
    this.profilePhotoUrl,
    this.roles,
    this.token,
    this.createdAt,
  });

  KasirModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    profilePhotoUrl = json['profile_photo_url'];
    roles = json['roles'];
    token = json['access_token'];
    createdAt = dateFormat.format(DateTime.parse(json['created_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'profilePhotoUrl': profilePhotoUrl,
      'roles': roles,
      'token': token,
      'createdAt': createdAt,
    };
  }
}

class UninitializedMemberModel extends KasirModel {}
