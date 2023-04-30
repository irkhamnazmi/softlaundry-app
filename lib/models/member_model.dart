class MemberModel {
  int? id;
  String? memberId;
  String? name;
  String? address;
  String? phoneNumber;

  MemberModel({
    this.id,
    this.memberId,
    this.name,
    this.address,
    this.phoneNumber,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
}
