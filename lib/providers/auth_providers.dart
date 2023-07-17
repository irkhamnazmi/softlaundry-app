import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/kasir_model.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late KasirModel _kasir;

  KasirModel get kasir => _kasir;

  set kasir(KasirModel kasir) {
    _kasir = kasir;
    notifyListeners();
  }

  Future<bool> login({
    String? phoneNumber,
    String? password,
  }) async {
    try {
      KasirModel kasir = await AuthService().login(
        phoneNumber: phoneNumber,
        password: password,
      );
      _kasir = kasir;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> profile() async {
    try {
      KasirModel kasir = await AuthService().profile();
      _kasir = kasir;
      // print(kasir.name);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
