import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/member_model.dart';
import 'package:softlaundryapp/providers/member_providers.dart';
import 'package:softlaundryapp/theme.dart';
import 'package:softlaundryapp/widgets/member_card.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  // Obtain shared preferences.
  MemberProvider? memberProvider;
  List<MemberModel> member = [];
  String? _value;
  bool? isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  getInit() async {
    await memberProvider!.all();
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
    memberProvider = Provider.of<MemberProvider>(context);
    if (isLoading == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInit());
    }
    member = memberProvider!.members;

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
                'Member',
                style: primaryTextStyle.copyWith(
                    fontSize: extralarge, fontWeight: semiBold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/member-add');
                },
                child: Image.asset(
                  'assets/add_user.png',
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
                  hintText: 'Cari Member', hintStyle: tertiaryTextStyle),
            ),
          ),
          SizedBox(
            height: large,
          ),
          Text(
            'Total Member : ${member.isNotEmpty ? member.length : 0}',
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
            member.isNotEmpty
                ? Column(
                    children: member
                        .where((x) =>
                            x.name!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()) ||
                            x.address!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()) ||
                            x.phoneNumber!
                                .toLowerCase()
                                .contains(_value ?? ''.toLowerCase()))
                        .map(
                          (member) => MemberCard(
                            member,
                          ),
                        )
                        .toList(),
                  )
                : Text(
                    'Tidak ada data',
                    style: tertiaryTextStyle.copyWith(fontWeight: medium),
                  ),
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
