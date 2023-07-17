import 'package:intl/intl.dart';

class MemberModel {
  int? id;
  String? memberId;
  String? name;
  String? address;
  String? phoneNumber;
  String? profilePhotoUrl;
  String? createdAt;
  DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy, hh:mm:ss', 'id');

  MemberModel({
    this.id,
    this.memberId,
    this.name,
    this.address,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.createdAt,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    profilePhotoUrl = json['profile_photo_url'];
    createdAt = dateFormat.format(DateTime.parse(json['created_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'profilePhotoUrl': profilePhotoUrl,
      'createdAt': createdAt,
    };
  }
}

class UninitializedMemberModel extends MemberModel {}
