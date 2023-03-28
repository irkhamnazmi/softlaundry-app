import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/layanan_card.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

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
                'Layanan',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/layanan-add');
                },
                child: Image.asset(
                  'assets/add.png',
                  height: 24,
                ),
              )
            ],
          ),
        )),
      );
    }

    Widget search() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: large, vertical: 11),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: tertiaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              style: secondaryTextStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Cari Layanan', hintStyle: tertiaryTextStyle),
            ),
          ),
          SizedBox(
            height: large,
          ),
          Text(
            'Total Layanan : 0',
            style: secondaryTextStyle.copyWith(
                fontSize: extraSmall, fontWeight: semiBold),
          )
        ],
      );
    }

    Widget listData() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard(),
            LayananCard()
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [
          header(),
          SizedBox(
            height: defaultMargin,
          ),
          search(),
          SizedBox(
            height: large,
          ),
          listData()
        ]),
      ),
    );
  }
}