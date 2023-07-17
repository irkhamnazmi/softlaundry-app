import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/shared_prefs.dart';

import '../theme.dart';

class KasirService {
  Future<List<KasirModel>> all() async {
    var url = '$baseUrl/cashiers';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['cashier'];
      List<KasirModel> cashier = [];

      for (var item in data) {
        cashier.add(KasirModel.fromJson(item));
      }
      return cashier;
    } else {
      throw Exception('Gagal Dapat kasier');
    }
  }

  Future<KasirModel> get({String? id}) async {
    var url = '$baseUrl/cashiers/get/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      KasirModel kasir = KasirModel.fromJson(data['cashier']);
      return kasir;
    } else {
      throw Exception('Gagal Dapat kasir');
    }
  }

  Future<KasirModel> add({
    String? name,
    String? address,
    String? email,
    String? phoneNumber,
    String? roles,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'name': name,
      'address': address,
      'email': address,
      'phone_number': phoneNumber,
      'password': 'softlaundry',
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
      return kasir;
    } else {
      throw Exception('Gagal tambah kasir');
    }
  }

  Future<KasirModel> edit({
    int? id,
    String? name,
    String? address,
    String? email,
    String? phoneNumber,
    String? roles,
    String? password,
  }) async {
    var url = '$baseUrl/cashiers/edit';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'id': id,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'roles': roles,
      'password': password,
    });

    var response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      KasirModel kasir = KasirModel.fromJson(data['cashier']);
      return kasir;
    } else {
      throw Exception('Gagal edit kasir');
    }
  }

  Future<bool> delete(int? id) async {
    var url = '$baseUrl/cashiers/delete/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Dapat kasir');
    }
  }
}
