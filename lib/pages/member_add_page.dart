import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:softlaundryapp/theme.dart';

class MemberAddPage extends StatefulWidget {
  const MemberAddPage({super.key});

  @override
  State<MemberAddPage> createState() => _MemberAddPageState();
}

class _MemberAddPageState extends State<MemberAddPage> {
  ScreenshotController screenshotController = ScreenshotController();

  var code = customAlphabet('1234567890', 10);
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
      return Screenshot(
        controller: screenshotController,
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(top: defaultMargin),
          child: Column(
            children: [
              QrImage(
                data: 'softlaundry-$code',
                size: 180,
                // You can include embeddedImageStyle Property if you
                //wanna embed an image from your Asset folder
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(
                    100,
                    100,
                  ),
                ),
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
                code,
                style: primaryTextStyle.copyWith(
                    fontSize: small, fontWeight: semiBold),
              )
            ],
          ),
        ),
      );
    }

    Widget buttonCreate() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: ElevatedButton(
            onPressed: () {
              _takeScreenShot();
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
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
          buttonCreate()
        ],
      ),
    );
  }

  void _takeScreenShot() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$code.png');
    await file.writeAsBytes(uint8List!);
    await Share.shareXFiles([XFile(file.path)]);
  }
}
