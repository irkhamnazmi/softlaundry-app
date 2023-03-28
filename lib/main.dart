import 'package:flutter/material.dart';
import 'package:softlaundryapp/pages/home/main_page.dart';
import 'package:softlaundryapp/pages/home/scan_page.dart';
import 'package:softlaundryapp/pages/kasir_add_page.dart';
import 'package:softlaundryapp/pages/kasir_edit_page.dart';
import 'package:softlaundryapp/pages/kasir_page.dart';
import 'package:softlaundryapp/pages/layanan_add_page.dart';
import 'package:softlaundryapp/pages/layanan_edit_page.dart';
import 'package:softlaundryapp/pages/layanan_page.dart';
import 'package:softlaundryapp/pages/login_page.dart';
import 'package:softlaundryapp/pages/member_add_page.dart';
import 'package:softlaundryapp/pages/member_edit_page.dart';
import 'package:softlaundryapp/pages/member_page.dart';
import 'package:softlaundryapp/pages/splash_page.dart';
import 'package:softlaundryapp/pages/transaksi_detail_page.dart';
import 'package:softlaundryapp/pages/transaksi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
        '/member': (context) => const MemberPage(),
        '/member-add': (context) => const MemberAddPage(),
        '/member-edit': (context) => const MemberEditPage(),
        '/kasir': (context) => const KasirPage(),
        '/kasir-add': (context) => const KasirAddPage(),
        '/kasir-edit': (context) => const KasirEditPage(),
        '/layanan': (context) => const LayananPage(),
        '/layanan-add': (context) => const LayananAddPage(),
        '/layanan-edit': (context) => const LayananEditPage(),
        '/transaksi': (context) => const TransaksiPage(),
        '/transaksi-detail': (context) => const TransaksiDetailPage(),
        '/scan': (context) => const ScanPage(),
      },
    );
  }
}
