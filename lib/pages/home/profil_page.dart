import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/pages/profile_edit_page.dart';
import 'package:softlaundryapp/theme.dart';

class ProfilPage extends StatelessWidget {
  final bool isCurrent;
  final KasirModel kasir;
  const ProfilPage(this.isCurrent, this.kasir, {super.key});

  @override
  Widget build(BuildContext context) {
    if (isCurrent == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setPrefs());
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        padding: EdgeInsets.all(large),
        child: Column(
          children: [
            ClipOval(
              child: Image.network(
                kasir.profilePhotoUrl!,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              kasir.name!,
              style: secondaryTextStyle.copyWith(
                  fontSize: large, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              kasir.roles!,
              style: primaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget menuItem(String text, String image) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: primaryTextStyle.copyWith(
                  fontSize: large, fontWeight: semiBold),
            ),
            Image.asset(
              image,
              height: 16,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        padding: EdgeInsets.symmetric(vertical: large),
        child: Column(
          children: [
            GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProfilEditPage(kasir)));
                },
                child: menuItem('Edit Profil', 'assets/right.png')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/tentang-kami');
                },
                child: menuItem('Tentang Kami', 'assets/right.png')),
            GestureDetector(
                onTap: () {
                  setLogout();
                  Navigator.popAndPushNamed(context, '/');
                },
                child: menuItem('Keluar', 'assets/keluar.png'))
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [header(), content()],
      ),
    );
  }
}

setPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('page', 0);
}

setLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', '');
}
