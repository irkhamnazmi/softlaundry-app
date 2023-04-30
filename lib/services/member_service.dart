import 'dart:convert';

import 'package:softlaundryapp/models/member_model.dart';
import 'package:http/http.dart' as http;

class MemberService {
  String baseUrl = 'https://api.rankep.com/softlaundry-web/public/api';

  Future<List<MemberModel>> getMember() async {
    var url = '$baseUrl/members';

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.https(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      List<MemberModel> members = [];

      for (var item in data) {
        members.add(MemberModel.fromJson(item));
      }
      return members;
    } else {
      throw Exception('Gagal Get Products');
    }
  }
}
