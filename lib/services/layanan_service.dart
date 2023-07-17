import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/layanan_model.dart';
import '../shared_prefs.dart';
import '../theme.dart';

class LayananService {
  // String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<List<LayananModel>> all() async {
    var url = '$baseUrl/services';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['service'];
      List<LayananModel> layanan = [];

      for (var item in data) {
        layanan.add(LayananModel.fromJson(item));
      }
      print(data);
      return layanan;
    } else {
      throw Exception('Gagal Dapat Layanan');
    }
  }

  Future<LayananModel> get({String? id}) async {
    var url = '$baseUrl/services/get/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      LayananModel layanan = LayananModel.fromJson(data['service']);
      return layanan;
    } else {
      throw Exception('Gagal Dapat layanan');
    }
  }

  Future<LayananModel> add({String? name, double? price}) async {
    var url = '$baseUrl/services/add';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'name': name,
      'price': price,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      LayananModel layanan = LayananModel.fromJson(data['service']);
      return layanan;
    } else {
      throw Exception('Gagal tambah layanan');
    }
  }

  Future<bool> edit({int? id, String? name, double? price}) async {
    var url = '$baseUrl/services/edit';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'id': id,
      'name': name,
      'price': price,
    });

    var response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal edit layanan');
    }
  }

  Future<bool> delete(int? id) async {
    var url = '$baseUrl/services/delete/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Hapus layanan');
    }
  }
}
