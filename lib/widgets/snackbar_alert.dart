import 'package:flutter/material.dart';

class SnackBarAlert {
  void alertMessage(BuildContext context, String? message, Color? alertColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: alertColor,
        content: Text(
          message!,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
