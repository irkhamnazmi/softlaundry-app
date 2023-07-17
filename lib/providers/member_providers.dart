import 'package:flutter/cupertino.dart';
import 'package:softlaundryapp/models/member_model.dart';
import 'package:softlaundryapp/services/member_service.dart';

class MemberProvider with ChangeNotifier {
  late MemberModel _member;

  MemberModel get member => _member;

  set member(MemberModel member) {
    _member = member;
    notifyListeners();
  }

  List<MemberModel> _members = [];
  List<MemberModel> get members => _members;

  set members(List<MemberModel> members) {
    _members = members;
    notifyListeners();
  }

  String? _memberId;

  String? get memberId => _memberId ?? '';

  set setMemberId(String value) {
    _memberId = value;
  }

  Future<List<MemberModel>> all() async {
    try {
      List<MemberModel> member = await MemberService().all();
      _members = member;
      return _members;
    } catch (e) {
      return _members;
    }
  }

  Future<bool> get(String? memberId) async {
    try {
      MemberModel member = await MemberService().get(memberId);
      _member = member;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> add(
      {String? name,
      String? memberId,
      String? address,
      String? phoneNumber}) async {
    try {
      MemberModel memberAdd = await MemberService().add(
        name: name,
        memberId: memberId,
        address: address,
        phoneNumber: phoneNumber,
      );
      _member = memberAdd;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> edit({
    String? memberId,
    String? name,
    String? address,
    String? phoneNumber,
  }) async {
    try {
      return await MemberService().edit(
        memberId: memberId,
        name: name,
        address: address,
        phoneNumber: phoneNumber,
      );

      // _kasir = kasirEdit;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(int? id) async {
    try {
      return await MemberService().delete(id);
    } catch (e) {
      return false;
    }
  }
}
