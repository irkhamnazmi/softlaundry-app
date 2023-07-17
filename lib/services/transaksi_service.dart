import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:softlaundryapp/models/transaksi_item_model.dart';
import 'package:softlaundryapp/models/transaksi_model.dart';

import '../shared_prefs.dart';
import '../theme.dart';

class TransaksiService {
  // String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<List<TransaksiModel>> all() async {
    var url = '$baseUrl/transactions';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['transaction'];
      List<TransaksiModel> transaksi = [];
      print(data);
      for (var item in data) {
        // transaksi.add(TransaksiModel.fromJson(item));
        transaksi.add(TransaksiModel.fromJson(item));
        // print(item);
      }
      return transaksi;
    } else {
      throw Exception('Gagal Dapat Transaksi');
    }
  }

  Future<TransaksiModel> get({String? id}) async {
    var url = '$baseUrl/transactions/get/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      TransaksiModel transaksi = TransaksiModel.fromJson(data['transaction']);
      return transaksi;
    } else {
      throw Exception('Gagal Dapat Transaksi');
    }
  }

  Future<TransaksiModel> add(
      {int? id, List<TransaksiItemModel>? items, double? totalPrice}) async {
    var url = '$baseUrl/transactions/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'members_id': id,
      'items': items
          ?.map((item) => {
                'id': item.layanan!.id,
                'weight': item.weight,
                'sub_price': item.subPrice,
              })
          .toList(),
      'total_price': totalPrice,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      TransaksiModel transaksi = TransaksiModel.fromJson(data['transaction']);
      print(transaksi);
      return transaksi;
    } else {
      throw Exception('Gagal tambah transaksi');
    }
  }

  Future<bool> delete(int? id) async {
    var url = '$baseUrl/transactions/delete/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Hapus Transaksi');
    }
  }
}
