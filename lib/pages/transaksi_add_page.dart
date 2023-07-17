import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/transaksi_item_model.dart';
import 'package:softlaundryapp/pages/transaksi_detail_page.dart';
import 'package:softlaundryapp/providers/layanan_provider.dart';
import 'package:softlaundryapp/providers/transaksi_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/item_card.dart';
import 'package:softlaundryapp/widgets/layanan_card.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../models/layanan_model.dart';
import '../models/member_model.dart';

class TransaksiAddPage extends StatefulWidget {
  final MemberModel member;
  const TransaksiAddPage(this.member, {super.key});

  @override
  State<TransaksiAddPage> createState() => _TransaksiAddPageState();
}

class _TransaksiAddPageState extends State<TransaksiAddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController layananController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController totalPrice = TextEditingController();
  TransaksiProvider? transaksiProvider;
  LayananProvider? layananProvider;
  bool isStrechedDropDown = false;
  bool? isLoading;
  SnackBarAlert? snackBarAlert;
  List<LayananModel> layanan = [];
  List<TransaksiItemModel> items = [];

  @override
  void initState() {
    snackBarAlert = SnackBarAlert();
    isLoading = true;
    nameController.text = widget.member.name!;
    super.initState();
  }

  getInit() async {
    await layananProvider!.all();
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _onPop() async {
    transaksiProvider!.setTransaksiItem = [];
    Navigator.popAndPushNamed(context, '/transaksi');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    layananProvider = Provider.of<LayananProvider>(context);
    transaksiProvider = Provider.of<TransaksiProvider>(context);

    layanan = layananProvider!.layanans;
    items = transaksiProvider!.transaksiItem;

    if (isLoading == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInit());
    }

    double total = transaksiProvider!.totalPrice();
    if (total.toString().isNotEmpty) {
      totalPrice.text = 'Rp ${total.toStringAsFixed(0)},-';
    }

    handleLayanan() async {
      // if (!mounted) return;
      return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                insetPadding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 100),
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Text(
                        'Pilih Layanan',
                        style: primaryTextStyle.copyWith(
                            fontSize: large, fontWeight: semiBold),
                      ),
                      const SizedBox(),
                      layanan.isNotEmpty
                          ? Column(
                              children: layanan
                                  .map(
                                    (layanan) => LayananCard(
                                      true,
                                      layanan,
                                    ),
                                  )
                                  .toList(),
                            )
                          : Text(
                              'Tidak ada data',
                              style: tertiaryTextStyle.copyWith(
                                  fontWeight: medium),
                            )
                    ],
                  ),
                ),
              ));
    }

    handleSubmit() async {
      if (items.isNotEmpty) {
        if (await transaksiProvider!
            .add(id: widget.member.id, items: items, totalPrice: total)) {
          setState(() {
            Route routes = MaterialPageRoute(
                builder: (BuildContext context) =>
                    TransaksiDetailPage(true, transaksiProvider!.transaksi));
            Navigator.pushAndRemoveUntil(
                context, routes, (route) => route.isFirst);
            transaksiProvider!.setTransaksiItem = [];
            snackBarAlert!.alertMessage(
                context, 'Sukses transaksi disimpan', primaryColor);
          });
        } else {
          setState(() {
            snackBarAlert!
                .alertMessage(context, 'Gagal transaksi disimpan', dangerColor);
          });
        }
      }
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
                  _onPop();
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Tambah Transaksi',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              const SizedBox()
            ],
          ),
        )),
      );
    }

    Widget idMember() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              // widget.member.memberId.toString(),
              '6758142442',
              style: primaryTextButtonStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget nameMemberInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama member',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: large, vertical: 11),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: tertiaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: nameController,
                style: tertiaryTextStyle,
                readOnly: true,
                decoration: InputDecoration.collapsed(
                    hintText: 'SoftLaundry', hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget layananInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Layanan',
                style: secondaryTextStyle.copyWith(fontWeight: semiBold),
              ),
              GestureDetector(
                onTap: handleLayanan,
                child: Image.asset(
                  'assets/add.png',
                  height: 18,
                ),
              ),
            ]),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                items.isNotEmpty
                    ? Column(
                        children: items
                            .map(
                              (transaksiItem) => ItemCard(
                                transaksiItem,
                              ),
                            )
                            .toList(),
                      )
                    : Text(
                        'Belum ditambahkan',
                        style: tertiaryTextStyle.copyWith(fontWeight: medium),
                      )
              ],
            ),
          ],
        ),
      );
    }

    Widget totalHargaInput() {
      return Container(
        width: 150,
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Harga',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: large, vertical: 11),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: tertiaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: totalPrice,
                style: tertiaryTextStyle,
                readOnly: true,
                decoration: InputDecoration.collapsed(
                    hintText: 'Rp 0,-', hintStyle: tertiaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            idMember(),
            nameMemberInput(),
            layananInput(),
            totalHargaInput(),
          ],
        ),
      );
    }

    Widget buttonSave() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: topMargin),
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
              'Simpan Data',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(children: [header(), content(), buttonSave()]),
        ),
      ),
    );
  }
}
