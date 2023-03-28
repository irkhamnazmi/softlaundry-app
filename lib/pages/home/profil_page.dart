import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          children: [
            Image.asset(
              'assets/user.png',
              height: 75,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Soft Laundry',
              style: secondaryTextStyle.copyWith(
                  fontSize: large, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Admin',
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
      return Expanded(
          child: Container(
        margin: EdgeInsets.only(top: defaultMargin),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: large),
        child: Column(
          children: [
            menuItem('Edit Profil', 'assets/right.png'),
            menuItem('Tentang Kami', 'assets/right.png'),
            menuItem('Keluar', 'assets/keluar.png')
          ],
        ),
      ));
    }

    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: defaultMargin, vertical: defaultMargin),
      children: [header(), content()],
    );
  }
}
