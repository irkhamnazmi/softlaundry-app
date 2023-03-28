import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class MemberAddPage extends StatelessWidget {
  const MemberAddPage({super.key});

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
                'Tambah Member',
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
          children: [
            Image.asset(
              'assets/qrcode.png',
              height: 180,
            ),
            SizedBox(
              height: large,
            ),
            Text(
              'ID Member Baru',
              style: secondaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '1122212',
              style: primaryTextStyle.copyWith(
                  fontSize: large, fontWeight: semiBold),
            )
          ],
        ),
      );
    }

    Widget buttonAdd() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              'Cetak Kode',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          header(),
          content(),
          SizedBox(
            height: defaultMargin,
          ),
          buttonAdd()
        ],
      ),
    );
  }
}
