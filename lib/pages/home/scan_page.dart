import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:softlaundryapp/pages/member_verifikasi_page.dart';
import 'package:softlaundryapp/pages/transaksi_add_page.dart';
import 'package:softlaundryapp/providers/member_providers.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

class ScanPage extends StatefulWidget {
  final String? from;
  const ScanPage(this.from, {super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  MemberProvider? memberProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    memberProvider = Provider.of<MemberProvider>(context, listen: false);
    snackBarAlert = SnackBarAlert();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    Widget header() {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(
              right: defaultMargin, left: defaultMargin, bottom: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.from!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/transaksi');
                      },
                      child: Image.asset(
                        'assets/left.png',
                        height: 24,
                        color: backgroundColor,
                      ),
                    )
                  : const SizedBox(),
              Text(
                'Arahkan ke QR Code',
                style: whiteTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              const SizedBox()
            ],
          ),
        )),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red, cutOutSize: scanArea),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: topMargin),
              child: Column(
                children: [
                  header(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      getMember(result!.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void getMember(String? memberId) async {
    if (await memberProvider!.get(memberId)) {
      if (memberProvider!.member.name != '-') {
        if (!mounted) return;
        Route routes = MaterialPageRoute(
            builder: (BuildContext context) =>
                TransaksiAddPage(memberProvider!.member));
        Navigator.pushAndRemoveUntil(context, routes, (route) => route.isFirst);
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MemberVerifikasiPage(memberId)));
      }
    } else {
      setState(() {
        snackBarAlert!
            .alertMessage(context, 'Tidak ditemukan id member', dangerColor);
      });
    }
  }
}
