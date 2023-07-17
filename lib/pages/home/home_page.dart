import 'package:flutter/material.dart';
import 'package:softlaundryapp/mobile_design_widget.dart';
import 'package:softlaundryapp/theme.dart';

import '../../models/member_model.dart';
import '../../models/transaksi_model.dart';

class HomePage extends StatefulWidget {
  final List<MemberModel> member;
  final List<TransaksiModel> transaksi;
  const HomePage(this.member, this.transaksi, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: topMargin, right: defaultMargin, left: defaultMargin),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logosplash.png',
                  width: 48,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Soft',
                  style: whiteTextStyle.copyWith(
                    fontSize: large,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Laundry',
                  style: yellowTextStyle.copyWith(
                    fontSize: large,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: topMargin,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/home_header.png',
                  width: 102,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text('Solusi Tepat Untuk Mencuci Pakaian Kotor Kamu!',
                      style: whiteTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.fade),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget statistik() {
      return Container(
        margin: EdgeInsets.only(
            top: topMargin, right: defaultMargin, left: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: cardColor1, borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaksi Member',
                      style: secondaryTextStyle.copyWith(
                          fontSize: small, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.transaksi.isNotEmpty
                          ? widget.transaksi.length.toString()
                          : '0',
                      style: primaryTextStyle.copyWith(
                          fontSize: extralarge, fontWeight: semiBold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: defaultMargin,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: cardColor2, borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Member',
                      style: secondaryTextStyle.copyWith(
                          fontSize: small, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.member.isNotEmpty
                          ? widget.member.length.toString()
                          : '0',
                      style: primaryTextStyle.copyWith(
                          fontSize: extralarge, fontWeight: semiBold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget mainMenu() {
      return Container(
        margin: EdgeInsets.only(
            top: topMargin, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu',
              style: primaryTextStyle.copyWith(
                  fontSize: extralarge, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/member');
                    },
                    child: Container(
                      padding: EdgeInsets.all(large),
                      decoration: BoxDecoration(
                          border: Border.all(color: tertiaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/member.png',
                            height: 48,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Member',
                            style: primaryTextButtonStyle.copyWith(
                                fontWeight: semiBold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: defaultMargin,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/kasir');
                    },
                    child: Container(
                      padding: EdgeInsets.all(large),
                      decoration: BoxDecoration(
                          border: Border.all(color: tertiaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/kasir.png',
                            height: 48,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Kasir',
                            style: primaryTextButtonStyle.copyWith(
                                fontWeight: semiBold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/layanan');
                    },
                    child: Container(
                      padding: EdgeInsets.all(large),
                      decoration: BoxDecoration(
                          border: Border.all(color: tertiaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/layanan.png',
                            height: 48,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Layanan',
                            style: primaryTextButtonStyle.copyWith(
                                fontWeight: semiBold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: defaultMargin,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/transaksi');
                    },
                    child: Container(
                      padding: EdgeInsets.all(large),
                      decoration: BoxDecoration(
                          border: Border.all(color: tertiaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/transaksi.png',
                            height: 48,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Transaksi',
                            style: primaryTextButtonStyle.copyWith(
                                fontWeight: semiBold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return MobileDesignWidget(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: 300,
                  color: primaryColor,
                ),
                Column(
                  children: [
                    header(),
                    SizedBox(
                      height: defaultMargin,
                    ),
                    statistik(),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            mainMenu(),
          ],
        ),
      ),
    );
  }
}
