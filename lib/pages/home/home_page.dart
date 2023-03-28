import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: defaultMargin,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Soft',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Laundry',
                  style: yellowTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultMargin,
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
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: cardColor1, borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaksi Member',
                    style: secondaryTextStyle.copyWith(
                        fontSize: extraSmall, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '0',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Member',
                    style: secondaryTextStyle.copyWith(
                        fontSize: extraSmall, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '0',
                    style: primaryTextStyle.copyWith(
                        fontSize: extralarge, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget mainMenu() {
      return Column(
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
                child: GestureDetector(
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
                child: GestureDetector(
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
                child: GestureDetector(
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
                child: GestureDetector(
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
      );
    }

    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              header(),
              SizedBox(
                height: defaultMargin,
              ),
              statistik(),
              SizedBox(
                height: defaultMargin,
              ),
              mainMenu()
            ],
          )),
    );
  }
}
