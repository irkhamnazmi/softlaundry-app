import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class LayananCard extends StatelessWidget {
  const LayananCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/layanan-edit');
      },
      child: Container(
        padding: EdgeInsets.only(top: large, bottom: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          children: [
            Image.asset(
              'assets/user.png',
              height: 50,
            ),
            SizedBox(
              width: large,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cucian Kiloan',
                  style: secondaryTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Rp 0',
                  style: secondaryTextStyle.copyWith(fontSize: small),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
