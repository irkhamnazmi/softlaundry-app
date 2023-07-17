import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softlaundryapp/providers/auth_providers.dart';
import 'package:softlaundryapp/providers/kasir_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../models/kasir_model.dart';

class ProfilEditPage extends StatefulWidget {
  final KasirModel? kasir;
  const ProfilEditPage(this.kasir, {super.key});

  @override
  State<ProfilEditPage> createState() => _ProfilEditPageState();
}

class _ProfilEditPageState extends State<ProfilEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  KasirProvider? kasirProvider;
  AuthProvider? authProvider;
  SnackBarAlert? snackBarAlert;
  int? result;

  @override
  void initState() {
    nameController.text = widget.kasir!.name!;
    addressController.text = widget.kasir!.address!;
    phoneNumberController.text = widget.kasir!.phoneNumber!;
    snackBarAlert = SnackBarAlert();
    super.initState();
  }

  void setPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('page', 1);
  }

  Future<bool> _onPop() async {
    setPref();
    Navigator.popAndPushNamed(context, '/home');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    kasirProvider = Provider.of<KasirProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);

    handleEdit() async {
      if (await kasirProvider!.edit(
          id: widget.kasir!.id,
          name: nameController.text,
          address: addressController.text,
          email: '',
          phoneNumber: phoneNumberController.text,
          roles: 'Admin',
          password: passController.text)) {
        result = 1;
        setState(() {
          authProvider!.profile();
          snackBarAlert!
              .alertMessage(context, 'Sukses data kasir diedit', primaryColor);
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
                  if (result == 1) {
                    _onPop();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Edit Profil',
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
                    hintText: 'Softlaundry name',
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
                    hintText: 'Softlaundry alamat',
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
                    hintText: '085773882', hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: secondaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: tertiaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: passController,
              style: secondaryTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                  hintText: '*****', hintStyle: secondaryTextStyle),
            ),
          )
        ],
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameInput(),
            addressInput(),
            phoneNumberInput(),
            passwordInput()
          ],
        ),
      );
    }

    Widget buttonEdit() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: topMargin),
        child: TextButton(
            onPressed: handleEdit,
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

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(children: [header(), content(), buttonEdit()]),
        ),
      ),
    );
  }
}
