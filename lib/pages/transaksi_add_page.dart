import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class TransaksiAddPage extends StatefulWidget {
  const TransaksiAddPage({super.key});

  @override
  State<TransaksiAddPage> createState() => _TransaksiAddPageState();
}

class _TransaksiAddPageState extends State<TransaksiAddPage> {
  bool isStrechedDropDown = false;

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
              '1',
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
                style: secondaryTextStyle,
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
            Text(
              'Layanan',
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Cucian Kotor',
                        style: secondaryTextStyle,
                      )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isStrechedDropDown = !isStrechedDropDown;
                          });
                        },
                        child: Image.asset(
                          isStrechedDropDown
                              ? 'assets/up.png'
                              : 'assets/down.png',
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                  isStrechedDropDown
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '- Cucian Kotor',
                                  style: secondaryTextStyle,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '- Cucian Kotor',
                                  style: secondaryTextStyle,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '- Cucian Kotor',
                                  style: secondaryTextStyle,
                                )),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget jumlahInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: large, vertical: 11),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: tertiaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
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
                style: secondaryTextStyle,
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
            jumlahInput(),
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
            onPressed: () {
              Navigator.popAndPushNamed(context, '/transaksi-success');
            },
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [header(), content(), buttonSave()]),
      ),
    );
  }
}
