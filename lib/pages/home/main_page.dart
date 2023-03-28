import 'package:flutter/material.dart';
import 'package:softlaundryapp/pages/home/home_page.dart';
import 'package:softlaundryapp/pages/home/profil_page.dart';
import 'package:softlaundryapp/pages/home/scan_page.dart';
import 'package:softlaundryapp/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ScanPage();
        case 2:
          return const ProfilPage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNav(),
      body: body(),
    );
  }
}
