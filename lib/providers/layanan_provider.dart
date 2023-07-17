import 'package:flutter/cupertino.dart';

import '../models/layanan_model.dart';
import '../services/layanan_service.dart';

class LayananProvider with ChangeNotifier {
  late LayananModel _layanan;

  LayananModel get layanan => _layanan;

  set layanan(LayananModel layanan) {
    _layanan = layanan;
    notifyListeners();
  }

  List<LayananModel> _layanans = [];
  List<LayananModel> get layanans => _layanans;

  set layanans(List<LayananModel> layanan) {
    _layanans = layanan;
    notifyListeners();
  }

  // String? _layananId;

  // String? get layananId => _layananId ?? '';

  // set setLayananId(String value) {
  //   _layananId = value;
  // }

  Future<bool> all() async {
    try {
      List<LayananModel> layanans = await LayananService().all();
      _layanans = layanans;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> get({String? id}) async {
    try {
      LayananModel layanan = await LayananService().get(id: id);
      _layanan = layanan;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> add({String? name, double? price}) async {
    try {
      LayananModel layananAdd = await LayananService().add(
        name: name,
        price: price,
      );
      _layanan = layananAdd;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> edit({int? id, String? name, double? price}) async {
    try {
      return await LayananService().edit(
        id: id,
        name: name,
        price: price,
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(int? id) async {
    try {
      return await LayananService().delete(id);
    } catch (e) {
      return false;
    }
  }
}
