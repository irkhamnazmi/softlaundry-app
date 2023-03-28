import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class TransaksiDetailPage extends StatelessWidget {
  const TransaksiDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(top: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/left.png',
                    height: 24,
                  ),
                ),
              ),
              Text(
                'Detail Transaksi',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              const SizedBox()
            ],
          ),
        )),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          header(),
          content(),
        ]),
      ),
    );
  }
}
