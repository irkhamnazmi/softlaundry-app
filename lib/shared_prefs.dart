import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get token => _sharedPrefs?.getString('token') ?? "";
  int get page => _sharedPrefs?.getInt('page') ?? 0;

  set token(String value) {
    _sharedPrefs?.setString('token', value);
  }

  set page(int value) {
    _sharedPrefs?.setInt('page', value);
  }
}

final sharedPrefs = SharedPrefs();
// constants/strings.dart
