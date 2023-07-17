import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/providers/layanan_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

class LayananAddPage extends StatefulWidget {
  const LayananAddPage({super.key});

  @override
  State<LayananAddPage> createState() => _LayananAddPageState();
}

class _LayananAddPageState extends State<LayananAddPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController(text: '');

  LayananProvider? layananProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    layananProvider = Provider.of<LayananProvider>(context, listen: false);
    snackBarAlert = SnackBarAlert();
  }

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      var name = nameController.text;

      var price = priceController.text != ''
          ? double.parse(priceController.text)
          : double.parse('0');

      if (await layananProvider!.add(name: name, price: price)) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/layanan');
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Sukses data layanan disimpan', primaryColor);
        });
      } else {
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Gagal data layanan disimpan', dangerColor);
        });
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
                  Navigator.popAndPushNamed(context, '/layanan');
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Tambah Layanan',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              const SizedBox()
            ],
          ),
        )),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
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
                style: secondaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: 'Ketik nama di sini',
                    hintStyle: tertiaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget hargaInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Harga',
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
                controller: priceController,
                style: secondaryTextStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration.collapsed(
                    hintText: 'ketik harga di sini',
                    hintStyle: tertiaryTextStyle),
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
            nameInput(),
            hargaInput(),
          ],
        ),
      );
    }

    Widget buttonAdd() {
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
              'Buat Data',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [header(), content(), buttonAdd()]),
      ),
    );
  }
}
