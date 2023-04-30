import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://softlaundry.co.id');

class TentangKamiPage extends StatelessWidget {
  const TentangKamiPage({super.key});

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Tentang Kami',
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
        margin: EdgeInsets.only(top: topMargin),
        child: Expanded(
          child: Column(
            children: [
              Image.asset(
                'assets/logosplash.png',
                width: 130,
              ),
              SizedBox(
                height: large,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Website',
                      style: secondaryTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl();
                      },
                      child: Text(
                        'www.softlaundry.co.id',
                        style: primaryTextButtonStyle,
                      ),
                    ),
                    SizedBox(
                      height: small,
                    ),
                    Text(
                      'App Version',
                      style: secondaryTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text(
                      'v1.0.0',
                      style: primaryTextStyle,
                    ),
                    SizedBox(
                      height: small,
                    ),
                    Text(
                      'Owner',
                      style: secondaryTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text(
                      'Siti Sofi',
                      style: primaryTextStyle,
                    ),
                    SizedBox(
                      height: small,
                    ),
                    Text(
                      'Design App by',
                      style: secondaryTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text(
                      'Johan',
                      style: primaryTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
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
          ]),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
