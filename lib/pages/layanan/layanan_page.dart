import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/providers/layanan_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/layanan_card.dart';

import '../../models/layanan_model.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({super.key});

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  LayananProvider? layananProvider;
  List<LayananModel> layanan = [];
  String? _value;
  bool? isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  getInit() async {
    await layananProvider!.all();
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _onPop() async {
    Navigator.popAndPushNamed(context, '/home');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    layananProvider = Provider.of<LayananProvider>(context);
    if (isLoading == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInit());
    }
    layanan = layananProvider!.layanans;
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
              ClipOval(
                child: GestureDetector(
                  onTap: _onPop,
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              style: secondaryTextStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Cari Layanan', hintStyle: tertiaryTextStyle),
            ),
          ),
          SizedBox(
            height: large,
          ),
          Text(
            'Total Layanan : ${layanan.isNotEmpty ? layanan.length : 0}',
            style: secondaryTextStyle.copyWith(
                fontSize: extraSmall, fontWeight: semiBold),
          ),
        ],
      );
    }

    Widget listData() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(),
            layanan.isNotEmpty
                ? Column(
                    children: layanan
                        .where((x) =>
                            x.name!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()) ||
                            x.price!
                                .toString()
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()))
                        .map(
                          (layanan) => LayananCard(
                            false,
                            layanan,
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
