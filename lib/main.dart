import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/pages/home/main_page.dart';
import 'package:softlaundryapp/pages/home/scan_page.dart';
import 'package:softlaundryapp/pages/kasir_add_page.dart';
import 'package:softlaundryapp/pages/kasir_page.dart';
import 'package:softlaundryapp/pages/layanan/layanan_add_page.dart';
import 'package:softlaundryapp/pages/layanan/layanan_page.dart';
import 'package:softlaundryapp/pages/login_page.dart';
import 'package:softlaundryapp/pages/member_add_page.dart';
import 'package:softlaundryapp/pages/member_page.dart';
import 'package:softlaundryapp/pages/splash_page.dart';
import 'package:softlaundryapp/pages/tentang_kami_page.dart';
import 'package:softlaundryapp/pages/transaksi_page.dart';
import 'package:softlaundryapp/providers/auth_providers.dart';
import 'package:softlaundryapp/providers/kasir_provider.dart';
import 'package:softlaundryapp/providers/layanan_provider.dart';
import 'package:softlaundryapp/providers/member_providers.dart';
import 'package:softlaundryapp/providers/transaksi_provider.dart';
import 'package:softlaundryapp/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (context) => KasirProvider()),
        ChangeNotifierProvider(create: (context) => LayananProvider()),
        ChangeNotifierProvider(create: (context) => TransaksiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const MainPage(),
          '/member': (context) => const MemberPage(),
          '/member-add': (context) => const MemberAddPage(),
          '/kasir': (context) => const KasirPage(),
          '/kasir-add': (context) => const KasirAddPage(),
          '/layanan': (context) => const LayananPage(),
          '/layanan-add': (context) => const LayananAddPage(),
          '/transaksi': (context) => const TransaksiPage(),
          '/scan': (context) => const ScanPage('transaksi'),
          '/tentang-kami': (context) => const TentangKamiPage(),
        },
      ),
    );
  }
}
