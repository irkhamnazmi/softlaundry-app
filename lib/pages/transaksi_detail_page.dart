import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/transaksi_model.dart';
import 'package:softlaundryapp/theme.dart';

class TransaksiDetailPage extends StatefulWidget {
  final bool? isLatest;
  final TransaksiModel transaksi;
  const TransaksiDetailPage(this.isLatest, this.transaksi, {super.key});

  @override
  State<TransaksiDetailPage> createState() => _TransaksiDetailPageState();
}

class _TransaksiDetailPageState extends State<TransaksiDetailPage> {
  bool? isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  getFinish() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLatest == true) {
      if (isLoading == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) => getFinish());
      }
    }

    Widget success() {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          height: 150,
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
                'Transaksi Berhasil',
                textAlign: TextAlign.center,
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
            ],
          ),
        ),
      );
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
              '${widget.transaksi.createdAt} WIB',
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
              widget.transaksi.member!.name!,
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
            Column(
                children: widget.transaksi.items!
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '- ',
                                  style: secondaryTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                                Expanded(
                                  child: Text(
                                    '${item.layanan!.name!} Rp ${item.layanan!.price!.toStringAsFixed(0)} x ${item.weight!.toStringAsFixed(0)} kg = Rp ${item.subPrice!.toStringAsFixed(0)} ',
                                    style: secondaryTextStyle.copyWith(
                                        fontWeight: semiBold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                    .toList()),
            SizedBox(
              height: small,
            ),
            Text(
              'Kasir',
              style: tertiaryTextStyle.copyWith(
                  fontSize: small, fontWeight: semiBold),
            ),
            Text(
              widget.transaksi.kasir!.name!,
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
              'Rp ${widget.transaksi.totalPrice!.toStringAsFixed(0)},-',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: small,
            ),
          ],
        ),
      );
    }

    Widget body() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [header(), content()]),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        body: widget.isLatest! == true
            ? isLoading! == true
                ? success()
                : body()
            : body());
  }
}
