import 'package:flutter/material.dart';
import 'package:softlaundryapp/pages/transaksi_detail_page.dart';
import 'package:softlaundryapp/theme.dart';

import '../models/transaksi_model.dart';

class TransaksiCard extends StatelessWidget {
  final TransaksiModel transaksi;
  const TransaksiCard(this.transaksi, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    TransaksiDetailPage(false, transaksi)));
      },
      child: Container(
        padding: EdgeInsets.only(top: large, bottom: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          children: [
            Image.network(
              transaksi.member!.profilePhotoUrl!,
              height: 50,
            ),
            SizedBox(
              width: large,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaksi.member!.name!,
                  style: secondaryTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  transaksi.items![0].layanan!.name!,
                  style: primaryTextStyle.copyWith(
                      fontSize: small, fontWeight: semiBold),
                ),
                Text(
                  '${transaksi.createdAt!} WIB',
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
