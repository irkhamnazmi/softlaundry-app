import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/member_model.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/snackbar_alert.dart';

import '../providers/member_providers.dart';

class MemberEditPage extends StatefulWidget {
  final MemberModel member;
  const MemberEditPage(this.member, {super.key});

  @override
  State<MemberEditPage> createState() => _MemberEditPageState();
}

class _MemberEditPageState extends State<MemberEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool? isLoading;
  MemberProvider? memberProvider;
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
    phoneNumberController.dispose();

    super.dispose();
  }

  getInit() async {
    memberProvider = Provider.of<MemberProvider>(context, listen: false);
    nameController.text = widget.member.name.toString();
    addressController.text = widget.member.address.toString();
    phoneNumberController.text = widget.member.phoneNumber.toString();
    snackBarAlert = SnackBarAlert();
  }

  @override
  Widget build(BuildContext context) {
    handleEdit() async {
      var name = nameController.text;
      var address = addressController.text;
      var phoneNumber = phoneNumberController.text;

      if (await memberProvider!.edit(
              memberId: widget.member.memberId,
              name: name,
              address: address,
              phoneNumber: phoneNumber) ==
          true) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/member');
        snackBarAlert!
            .alertMessage(context, 'Sukses Edit Member', primaryColor);
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Gagal Edit Member', dangerColor);
        });
      }
    }

    handleDelete() async {
      if (await memberProvider!.delete(widget.member.id)) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/member');
        snackBarAlert!
            .alertMessage(context, 'Sukses Hapus Member', primaryColor);
      } else {
        setState(() {
          snackBarAlert!
              .alertMessage(context, 'Gagal Hapus Member', dangerColor);
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
                  Navigator.popAndPushNamed(context, '/member');
                },
                child: Image.asset(
                  'assets/left.png',
                  height: 24,
                ),
              ),
              Text(
                'Edit Member',
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
              widget.member.memberId.toString(),
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
                    hintText: 'Masukkan Nama Member',
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
                minLines: 4,
                maxLines: null,
                controller: addressController,
                keyboardType: TextInputType.multiline,
                style: secondaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan alamat', hintStyle: secondaryTextStyle),
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
                keyboardType: TextInputType.phone,
                style: secondaryTextStyle,
                controller: phoneNumberController,
                decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan nomor hp',
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

    Widget buttonEdit() {
      var textButton = TextButton(
          onPressed: handleEdit,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            'Ubah Data',
            style: whiteTextStyle.copyWith(fontWeight: semiBold),
          ));
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: textButton,
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
