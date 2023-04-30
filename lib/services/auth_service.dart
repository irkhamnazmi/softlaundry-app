import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softlaundryapp/models/cashier_model.dart';

class AuthService {
  String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<CashierModel> login({
    String? phoneNumber,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'phoneNumber': phoneNumber,
      'password': password,
    });

    var response = await http.post(
      Uri.https(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CashierModel user = CashierModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setString('token', 'Bearer ' + data['access_token']);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<CashierModel> getCashier({required String token}) async {
    var url = '$baseUrl/user';

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CashierModel user = CashierModel.fromJson(data);
      return user;
    } else {
      throw Exception('Gagal Get User');
    }
  }
}
