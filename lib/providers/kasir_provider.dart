import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/services/kasir_service.dart';

class KasirProvider with ChangeNotifier {
  late KasirModel _kasir;

  KasirModel get kasir => _kasir;

  List<KasirModel> _kasirs = [];
  List<KasirModel> get kasirs => _kasirs;

  set setKasir(KasirModel kasir) {
    _kasir = kasir;
    notifyListeners();
  }

  set kasirs(List<KasirModel> kasirs) {
    _kasirs = kasirs;
    notifyListeners();
  }

  // String? _kasirId;

  // String? get kasirId => _kasirId ?? '';

  // set setKasirId(String value) {
  //   _kasirId = value;
  // }

  Future<bool> all() async {
    try {
      List<KasirModel> kasirs = await KasirService().all();
      _kasirs = kasirs;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> get(String? id) async {
    try {
      KasirModel kasir = await KasirService().get(id: id);
      setKasir = kasir;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> add(
      {String? name,
      String? address,
      String? email,
      String? phoneNumber}) async {
    try {
      KasirModel kasirAdd = await KasirService().add(
        name: name,
        address: address,
        email: email,
        phoneNumber: phoneNumber,
      );
      setKasir = kasirAdd;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> edit(
      {int? id,
      String? name,
      String? address,
      String? email,
      String? phoneNumber,
      String? roles,
      String? password}) async {
    try {
      KasirModel kasir = await KasirService().edit(
        id: id,
        name: name,
        address: address,
        email: email,
        phoneNumber: phoneNumber,
        roles: roles,
        password: password,
      );

      setKasir = kasir;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(int? id) async {
    try {
      return await KasirService().delete(id);
    } catch (e) {
      return false;
    }
  }
}
