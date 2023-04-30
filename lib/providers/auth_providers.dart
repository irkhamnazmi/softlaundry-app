import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/cashier_model.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late CashierModel _cashier;

  CashierModel get cashier => _cashier;

  set cashier(CashierModel cashier) {
    _cashier = cashier;
    notifyListeners();
  }

  Future<bool> login({
    String? phoneNumber,
    String? password,
  }) async {
    try {
      CashierModel cashier = await AuthService().login(
        phoneNumber: phoneNumber,
        password: password,
      );
      _cashier = cashier;

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> getCashier({
    required String token,
  }) async {
    try {
      CashierModel cashier = await AuthService().getCashier(
        token: token,
      );
      _cashier = cashier;

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }
}
