import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../providers/member_providers.dart';

class MemberVerifikasiPage extends StatefulWidget {
  final String? memberId;
  const MemberVerifikasiPage(this.memberId, {super.key});

  @override
  State<MemberVerifikasiPage> createState() => _MemberVerifikasiPageState();
}

class _MemberVerifikasiPageState extends State<MemberVerifikasiPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  MemberProvider? memberProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    memberProvider = Provider.of<MemberProvider>(context, listen: false);
    snackBarAlert = SnackBarAlert();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      var name = nameController.text;
      var address = addressController.text;
      var phoneNumber = phoneNumberController.text;

      if (await memberProvider!.edit(
              memberId: widget.memberId,
              name: name,
              address: address,
              phoneNumber: phoneNumber) ==
          true) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/member');
        snackBarAlert!.alertMessage(
            context, 'Sukses verifikasi member baru', primaryColor);
      } else {
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Gagal verifikasi member baru', dangerColor);
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
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Verifikasi Member',
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
              'ID Member',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.memberId!,
              style: primaryTextButtonStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),
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
                    hintText: 'Isikan nama di sini',
                    hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget addressInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat',
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
                controller: addressController,
                minLines: 4,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: secondaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: 'Isikan alamat di sini',
                    hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget phoneNumberInput() {
      return Container(
        margin: EdgeInsets.only(bottom: large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Hp',
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
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                style: secondaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: 'Isikan Nomor Hp di sini',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            idMember(),
            nameInput(),
            addressInput(),
            phoneNumberInput(),
          ],
        ),
      );
    }

    Widget buttonVerfikasi() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
            onPressed: handleSubmit,
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              'Verifikasi',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(children: [header(), content(), buttonVerfikasi()]),
      ),
    );
  }
}
