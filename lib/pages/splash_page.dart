import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/mobile_design_widget.dart';
import 'package:softlaundryapp/providers/auth_providers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    if (await authProvider.profile()) {
      Timer(const Duration(milliseconds: 1),
          () => Navigator.popAndPushNamed(context, '/home'));
    } else {
      Timer(const Duration(seconds: 1),
          () => Navigator.popAndPushNamed(context, '/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 130,
            height: 150,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logosplash.png'))),
          ),
        ),
      ),
    );
  }
}
