import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/providers/kasir_provider.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

class KasirAddPage extends StatefulWidget {
  const KasirAddPage({super.key});

  @override
  State<KasirAddPage> createState() => _KasirAddPageState();
}

class _KasirAddPageState extends State<KasirAddPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');

  bool? isLoading;
  KasirProvider? kasirProvider;
  SnackBarAlert? snackBarAlert;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    snackBarAlert = SnackBarAlert();
    kasirProvider = Provider.of<KasirProvider>(context, listen: false);
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
      var email = emailController.text;
      var phoneNumber = phoneNumberController.text;

      if (await kasirProvider!.add(
              name: name,
              address: address,
              email: email,
              phoneNumber: phoneNumber) ==
          true) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/kasir');
        setState(() {
          snackBarAlert!.alertMessage(
              context, 'Sukses data kasir disimpan', primaryColor);
        });
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Gagal data kasir disimpan', dangerColor);
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
                child: GestureDetector(
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
                'Tambah Kasir',
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
                    hintText: 'ketik nama di sini',
                    hintStyle: tertiaryTextStyle),
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
                    hintText: 'ketik alamat di sini',
                    hintStyle: tertiaryTextStyle),
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
                    hintText: 'ketik nomor hp di sini',
                    hintStyle: tertiaryTextStyle),
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
                  hintText: 'ketik email di sini',
                  hintStyle: tertiaryTextStyle),
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
