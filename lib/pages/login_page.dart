import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/providers/auth_providers.dart';
import 'package:softlaundryapp/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');
  String? phoneNum, pass;

  Future<bool> _onPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      phoneNum = phoneNumberController.text;
      pass = passwordController.text;

      if (await authProvider.login(phoneNumber: phoneNum, password: pass)) {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/home');
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: const Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

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
            'Masuk ke SoftLaundry',
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
              controller: phoneNumberController,
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
              controller: passwordController,
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
            onPressed: handleLogin,
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

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
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
      ),
    );
  }
}
