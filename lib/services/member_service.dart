import 'dart:convert';

import 'package:softlaundryapp/models/member_model.dart';
import 'package:http/http.dart' as http;
import 'package:softlaundryapp/shared_prefs.dart';

import '../theme.dart';

class MemberService {
  // String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<List<MemberModel>> all() async {
    var url = '$baseUrl/members';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['member'];
      List<MemberModel> member = [];
      for (var item in data) {
        member.add(MemberModel.fromJson(item));
      }
      return member;
    } else {
      throw Exception('Gagal Dapat Member');
    }
  }

  Future<MemberModel> get(String? memberId) async {
    var url = '$baseUrl/members/get/$memberId';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      MemberModel member = MemberModel.fromJson(data['member']);
      return member;
    } else {
      throw Exception('Gagal Dapat member');
    }
  }

  Future<MemberModel> add({
    String? name,
    String? memberId,
    String? address,
    String? phoneNumber,
  }) async {
    var url = '$baseUrl/members/add';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'name': name,
      'member_id': memberId,
      'address': address,
      'phone_number': phoneNumber,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      MemberModel member = MemberModel.fromJson(data['member']);
      return member;
    } else {
      throw Exception('Gagal tambah member');
    }
  }

  Future<bool> edit({
    String? memberId,
    String? name,
    String? address,
    String? phoneNumber,
  }) async {
    var url = '$baseUrl/members/edit';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };
    var body = jsonEncode({
      'member_id': memberId,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
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
      throw Exception('Gagal edit member');
    }
  }

  Future<bool> delete(int? id) async {
    var url = '$baseUrl/members/delete/$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': sharedPrefs.token
    };

    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Dapat member');
    }
  }
}
