import 'package:intl/intl.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/models/member_model.dart';
import 'package:softlaundryapp/models/transaksi_item_model.dart';

class TransaksiModel {
  int? id;
  MemberModel? member;
  KasirModel? kasir;
  List<TransaksiItemModel>? items;
  double? totalPrice;
  String? createdAt;
  DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy, hh:mm:ss', 'id');

  TransaksiModel({
    this.id,
    this.member,
    this.kasir,
    this.items,
    this.totalPrice,
    this.createdAt,
  });

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    member = MemberModel.fromJson(json['member']);
    kasir = KasirModel.fromJson(json['cashier']);
    totalPrice = double.parse(json['total_price'].toString());
    createdAt = dateFormat.format(DateTime.parse(json['created_at']));
    items = json['items']
        .map<TransaksiItemModel>((items) => TransaksiItemModel.fromJson(items))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member': member!.toJson(),
      'kasir': kasir!.toJson(),
      'totalPrice': totalPrice,
      'createdAt': createdAt,
      'items': items!.map((items) => items.toJson()).toList(),
    };
  }
}

class UninitializedTransaksiModel extends TransaksiModel {}
