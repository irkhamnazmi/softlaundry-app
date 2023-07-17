import 'package:flutter/cupertino.dart';
import 'package:softlaundryapp/models/transaksi_item_model.dart';
import 'package:softlaundryapp/models/transaksi_model.dart';
import 'package:softlaundryapp/services/transaksi_service.dart';

import '../models/layanan_model.dart';

class TransaksiProvider with ChangeNotifier {
  late TransaksiModel _transaksi;

  TransaksiModel get transaksi => _transaksi;

  set transaksi(TransaksiModel transaksi) {
    _transaksi = transaksi;
    notifyListeners();
  }

  List<TransaksiModel> _transaksis = [];
  List<TransaksiModel> get transaksis => _transaksis;

  List<TransaksiItemModel> _transaksiItem = [];
  List<TransaksiItemModel> get transaksiItem => _transaksiItem;

  set transaksis(List<TransaksiModel> transaksi) {
    _transaksis = transaksi;
    notifyListeners();
  }

  set setTransaksiItem(List<TransaksiItemModel> transaksi) {
    _transaksiItem = transaksi;
    notifyListeners();
  }

  addItem(LayananModel layanan) async {
    if (layananExist(layanan)) {
      int index = _transaksiItem
          .indexWhere((element) => element.layanan!.id == layanan.id);
      _transaksiItem[index].weight = _transaksiItem[index].weight! + 1;
      _transaksiItem[index].subPrice =
          getSubPrice(layanan.price, _transaksiItem[index].weight);
      notifyListeners();
    } else {
      _transaksiItem.add(TransaksiItemModel(
          id: _transaksiItem.length,
          layanan: layanan,
          weight: 1,
          subPrice: getSubPrice(layanan.price, 1)));
      notifyListeners();
    }
  }

  editWeight(int id, double v) {
    int index =
        _transaksiItem.indexWhere((element) => element.layanan!.id == id);
    _transaksiItem[index].weight = v;
    _transaksiItem[index].subPrice = getSubPrice(
        transaksiItem[index].layanan!.price!, _transaksiItem[index].weight);
    notifyListeners();
  }

  removeItem(int id) {
    _transaksiItem.removeAt(id);
    notifyListeners();
  }

  addWeight(int id) {
    _transaksiItem[id].weight = _transaksiItem[id].weight! + 1;
    _transaksiItem[id].subPrice = getSubPrice(
        _transaksiItem[id].layanan!.price!, _transaksiItem[id].weight);
    notifyListeners();
  }

  reduceWeight(int id) {
    _transaksiItem[id].weight = _transaksiItem[id].weight! - 1;
    _transaksiItem[id].subPrice = getSubPrice(
        _transaksiItem[id].layanan!.price!, _transaksiItem[id].weight);
    if (_transaksiItem[id].weight! <= 0) {
      _transaksiItem.removeAt(id);
      notifyListeners();
    }
    notifyListeners();
  }

  double getSubPrice(double? price, double? weight) {
    return price! * weight!;
  }

  totalPrice() {
    double total = 0;
    for (var item in _transaksiItem) {
      total += (item.subPrice!);
    }

    return total;
  }

  layananExist(LayananModel layanan) {
    if (_transaksiItem
            .indexWhere((element) => element.layanan!.id == layanan.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<TransaksiModel>> all() async {
    try {
      List<TransaksiModel> transaksis = await TransaksiService().all();
      _transaksis = transaksis;
      print(_transaksis);
      return _transaksis;
    } catch (e) {
      return _transaksis;
    }
  }

  Future<bool> get({String? id}) async {
    try {
      TransaksiModel transaksi = await TransaksiService().get(id: id);
      _transaksi = transaksi;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> add(
      {int? id, List<TransaksiItemModel>? items, double? totalPrice}) async {
    try {
      TransaksiModel transaksiAdd = await TransaksiService().add(
        id: id,
        items: items,
        totalPrice: totalPrice,
      );
      _transaksi = transaksiAdd;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(int? id) async {
    try {
      return await TransaksiService().delete(id);
    } catch (e) {
      return false;
    }
  }
}
