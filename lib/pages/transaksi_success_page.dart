import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class TransaksiSuccessPage extends StatelessWidget {
  const TransaksiSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(top: topMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/centang.png',
                height: 70,
              ),
              SizedBox(
                height: large,
              ),
              Text(
                'Berhasil',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
            ],
          ),
        )),
      );
    }

    Widget buttonBack() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: topMargin),
        child: ElevatedButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/transaksi');
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              'Lihat Daftar Transaksi',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              'Senin, 1/1/2023 13:00 WIB',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
            Text(
              'Nama Member',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              'SoftLaundry',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
            Text(
              'Layanan',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              'Cuci Kiloan',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
            Text(
              'Jumlah',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              '0',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
            Text(
              'Kasir',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              'Softlaundry kasir',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
            Text(
              'Total Harga',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              'Rp 0,-',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            header(),
            content(),
            buttonBack(),
          ]),
    );
  }
}
