import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/providers/layanan_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../../models/layanan_model.dart';

class LayananEditPage extends StatefulWidget {
  final LayananModel layanan;
  const LayananEditPage(this.layanan, {super.key});

  @override
  State<LayananEditPage> createState() => _LayananEditPageState();
}

class _LayananEditPageState extends State<LayananEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  LayananProvider? layananProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    layananProvider = Provider.of<LayananProvider>(context, listen: false);
    nameController.text = widget.layanan.name.toString();
    priceController.text = widget.layanan.price.toString();
    snackBarAlert = SnackBarAlert();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      var name = nameController.text;
      var price = priceController.text;

      if (await layananProvider!.edit(
          id: widget.layanan.id, name: name, price: double.parse(price))) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/layanan');
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Sukses data layanan diedit', primaryColor);
        });
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Gagal data layanan diedit', dangerColor);
        });
      }
    }

    handleDelete() async {
      if (await layananProvider!.delete(widget.layanan.id)) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/layanan');
      } else {
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Sukses data layanan dihapus', primaryColor);
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
                'Edit Layanan',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              InkWell(
                onTap: handleDelete,
                child: Image.asset(
                  'assets/trash.png',
                  height: 24,
                ),
              )
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
                    hintText: 'isikan nama di sini',
                    hintStyle: secondaryTextStyle),
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
                    hintText: 'isikan harga disini',
                    hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nameInput(),
              hargaInput(),
            ],
          ),
        ),
      );
    }

    Widget buttonEdit() {
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
              'Ubah Data',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [header(), content(), buttonEdit()]),
      ),
    );
  }
}
