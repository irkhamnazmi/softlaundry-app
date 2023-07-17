import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:softlaundryapp/providers/member_providers.dart';

import 'package:softlaundryapp/theme.dart';

import '../widgets/snackbar_alert.dart';

class MemberAddPage extends StatefulWidget {
  const MemberAddPage({super.key});

  @override
  State<MemberAddPage> createState() => _MemberAddPageState();
}

class _MemberAddPageState extends State<MemberAddPage> {
  ScreenshotController screenshotController = ScreenshotController();
  MemberProvider? memberProvider;
  SnackBarAlert? snackBarAlert;

  var code = customAlphabet('1234567890', 10);

  @override
  void initState() {
    memberProvider = Provider.of<MemberProvider>(context, listen: false);
    snackBarAlert = SnackBarAlert();
    super.initState();
  }

  _saveMemberId() async {
    if (await memberProvider!
        .add(memberId: code, name: '-', address: '-', phoneNumber: '-')) {
      _takeScreenShot();
      if (!mounted) return;
      Navigator.pop(context);
      setState(() {
        snackBarAlert!
            .alertMessage(context, 'Sukses id member disimpan', primaryColor);
      });
    } else {
      setState(() {
        Navigator.pop(context);
        snackBarAlert!
            .alertMessage(context, 'Gagal id member disimpan', dangerColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) => SizedBox(
                width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                child: AlertDialog(
                  backgroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Apakah member id ini akan dicetak dan disimpan ke database?',
                          style: primaryTextStyle.copyWith(
                              fontSize: large, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: large,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: defaultMargin),
                          child: ElevatedButton(
                            onPressed: _saveMemberId,
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              'Ya, Lanjutkan',
                              style: whiteTextStyle.copyWith(
                                  fontSize: small, fontWeight: semiBold),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Nanti',
                            style: primaryTextStyle.copyWith(
                                fontSize: small, fontWeight: medium),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
    }

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
              QrImageView(
                data: code,
                size: 180,
                // You can include embeddedImageStyle Property if you
                //wanna embed an image from your Asset folder
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(
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
            onPressed: handleSubmit,
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
