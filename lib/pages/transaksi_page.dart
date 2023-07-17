import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/transaksi_model.dart';
import 'package:softlaundryapp/providers/transaksi_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/transaksi_card.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  TransaksiProvider? transaksiProvider;
  List<TransaksiModel> transaksi = [];
  String? _value;

  bool? isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  getInit() async {
    await transaksiProvider!.all();
    if (mounted == true) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _onPop() async {
    Navigator.popAndPushNamed(context, '/home');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    transaksiProvider = Provider.of<TransaksiProvider>(context);
    if (isLoading == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInit());
    }

    transaksi = transaksiProvider!.transaksis;
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
                onTap: _onPop,
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Transaksi',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/scan');
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              style: secondaryTextStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Cari Transaksi', hintStyle: tertiaryTextStyle),
            ),
          ),
          SizedBox(
            height: large,
          ),
          Text(
            'Total Transaksi : ${transaksi.isNotEmpty ? transaksi.length : 0}',
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
          children: [
            const SizedBox(),
            transaksi.isNotEmpty
                ? Column(
                    children: transaksi
                        .where((x) =>
                            x.member!.name!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()) ||
                            x.items![0].layanan!.name!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()) ||
                            x.createdAt!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()))
                        .map(
                          (transaksi) => TransaksiCard(
                            transaksi,
                          ),
                        )
                        .toList(),
                  )
                : Text(
                    'Tidak ada data',
                    style: tertiaryTextStyle.copyWith(fontWeight: medium),
                  )
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(children: [
            header(),
            SizedBox(
              height: topMargin,
            ),
            search(),
            SizedBox(
              height: large,
            ),
            listData()
          ]),
        ),
      ),
    );
  }
}
