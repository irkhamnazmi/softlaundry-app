import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../providers/kasir_provider.dart';

class KasirEditPage extends StatefulWidget {
  final KasirModel kasir;

  const KasirEditPage(this.kasir, {super.key});

  @override
  State<KasirEditPage> createState() => _KasirEditPageState();
}

class _KasirEditPageState extends State<KasirEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool? isLoading;
  KasirProvider? kasirProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  getInit() async {
    nameController.text = widget.kasir.name.toString();
    addressController.text = widget.kasir.address.toString();
    emailController.text = widget.kasir.email.toString();
    phoneNumberController.text = widget.kasir.phoneNumber.toString();
    kasirProvider = Provider.of<KasirProvider>(context, listen: false);
    snackBarAlert = SnackBarAlert();
  }

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      var name = nameController.text;
      var address = addressController.text;
      var email = emailController.text;
      var phoneNumber = phoneNumberController.text;

      if (await kasirProvider!.edit(
        id: widget.kasir.id,
        name: name,
        address: address,
        email: email,
        phoneNumber: phoneNumber,
        roles: widget.kasir.roles,
        password: widget.kasir.password,
      )) {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Sukses data kasir diedit', primaryColor);
        });
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Gagal data kasir diedit', dangerColor);
        });
      }
    }

    handleDelete() async {
      if (await kasirProvider!.delete(widget.kasir.id)) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/kasir');
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Sukses data kasir dihapus', primaryColor);
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
              ClipOval(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/kasir');
                  },
                  child: Image.asset(
                    'assets/left.png',
                    height: 24,
                  ),
                ),
              ),
              Text(
                'Edit Kasir',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
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
                    hintText: 'Isikan nomor hp di sini',
                    hintStyle: secondaryTextStyle),
              ),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
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
              controller: emailController,
              style: secondaryTextStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Isikan email di sini',
                  hintStyle: secondaryTextStyle),
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
            emailInput()
          ],
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
