import 'layanan_model.dart';

class TransaksiItemModel {
  int? id;
  double? weight;
  LayananModel? layanan;
  double? subPrice;

  TransaksiItemModel({
    this.id,
    this.weight,
    this.layanan,
    this.subPrice,
  });

  TransaksiItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = double.parse(json['weight'].toString());
    layanan = LayananModel.fromJson(json['service']);
    subPrice = double.parse(json['sub_price'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'layanan': layanan!.toJson(),
      'subPrice': subPrice,
    };
  }
}
