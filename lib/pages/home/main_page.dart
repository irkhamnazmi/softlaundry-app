import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/pages/home/home_page.dart';
import 'package:softlaundryapp/pages/home/profil_page.dart';
import 'package:softlaundryapp/pages/home/scan_page.dart';
import 'package:softlaundryapp/providers/auth_providers.dart';
import 'package:softlaundryapp/theme.dart';

import '../../models/kasir_model.dart';
import '../../models/member_model.dart';
import '../../models/transaksi_model.dart';
import '../../providers/member_providers.dart';
import '../../providers/transaksi_provider.dart';
import '../../shared_prefs.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  bool? isCurrent;
  AuthProvider? authProvider;
  KasirModel? kasir;
  MemberProvider? memberProvider;
  TransaksiProvider? transaksiProvider;
  List<MemberModel> member = [];
  List<TransaksiModel> transaksi = [];

  bool? isLoading;

  @override
  void initState() {
    isLoading = true;
    isCurrent = false;
    super.initState();
  }

  getInit() async {
    await memberProvider!.all();
    await transaksiProvider!.all();
    await authProvider!.profile();

    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _onPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    memberProvider = Provider.of<MemberProvider>(context);
    transaksiProvider = Provider.of<TransaksiProvider>(context);
    if (isLoading == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInit());
    }

    if (sharedPrefs.page != 0) {
      currentIndex = 2;
      isCurrent = true;
    }

    kasir = authProvider!.kasir;
    member = memberProvider!.members;
    transaksi = transaksiProvider!.transaksis;

    Widget bottomNav() {
      return ClipRRect(
          child: BottomAppBar(
        color: backgroundColor,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          backgroundColor: backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon_home.png',
                height: 24,
                color: currentIndex == 0 ? primaryColor : secondaryTextColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon_scan.png',
                height: 24,
                color: currentIndex == 1 ? primaryColor : secondaryTextColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon_profil.png',
                height: 24,
                color: currentIndex == 2 ? primaryColor : secondaryTextColor,
              ),
              label: '',
            ),
          ],
        ),
      ));
    }

    Widget? body() {
      switch (currentIndex) {
        case 0:
          return HomePage(member, transaksi);
        case 1:
          return const ScanPage('');
        case 2:
          return ProfilPage(isCurrent!, kasir!);
        default:
          HomePage(member, transaksi);
      }
      return null;
    }

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
          backgroundColor: backgroundColor,
          bottomNavigationBar: bottomNav(),
          body: body()),
    );
  }
}
