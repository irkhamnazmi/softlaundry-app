import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class TransaksiCard extends StatelessWidget {
  const TransaksiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/transaksi-detail');
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
                  'SoftLaundry',
                  style: secondaryTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Cuci Kiloan',
                  style: primaryTextStyle.copyWith(
                      fontSize: small, fontWeight: semiBold),
                ),
                Text(
                  'Senin, 01/01/2023 13:00:00 WIB',
                  style: secondaryTextStyle.copyWith(
                      fontSize: extraSmall, fontWeight: medium),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
