import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/shared_prefs.dart';

import '../theme.dart';

class AuthService {
  // String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<KasirModel> login({
    String? phoneNumber,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'phone_number': phoneNumber,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      KasirModel kasir = KasirModel.fromJson(data['cashier']);
      kasir.token = 'Bearer ' + data['access_token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', 'Bearer ' + data['access_token']);

      return kasir;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<KasirModel> profile() async {
    var url = '$baseUrl/profile';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      KasirModel kasir = KasirModel.fromJson(data['cashier']);
      print(response.body);
      return kasir;
    } else {
      throw Exception('Gagal login');
    }
  }
}
