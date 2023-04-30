import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: primaryTextStyle.copyWith(
                fontSize: extralarge, fontWeight: semiBold),
          ),
          const SizedBox(),
          Text(
            'Masuk ke Soft Laundry',
            style: secondaryTextStyle.copyWith(
                fontSize: extraSmall, fontWeight: regular),
          ),
        ],
      );
    }

    Widget phoneNumber() {
      return Column(
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
              style: secondaryTextStyle,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration.collapsed(
                  hintText: 'ketik email Anda di sini',
                  hintStyle: tertiaryTextStyle),
            ),
          )
        ],
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
              style: secondaryTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                  hintText: 'ketik password Anda di sini',
                  hintStyle: tertiaryTextStyle),
            ),
          )
        ],
      );
    }

    Widget buttonLogin() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              'Login',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            )),
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Jika lupa akun? ',
            style: secondaryTextStyle.copyWith(fontSize: 12),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Hubungi kami',
              style: primaryTextButtonStyle.copyWith(fontSize: 12),
            ),
          )
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: topMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              const SizedBox(
                height: 84,
              ),
              phoneNumber(),
              const SizedBox(
                height: 16,
              ),
              passwordInput(),
              const SizedBox(
                height: 16,
              ),
              buttonLogin(),
              const Spacer(),
              footer()
            ],
          ),
        ),
      ),
    );
  }
}
