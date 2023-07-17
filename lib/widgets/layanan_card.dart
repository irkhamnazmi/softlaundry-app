import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/layanan_model.dart';
import 'package:softlaundryapp/providers/transaksi_provider.dart';
import 'package:softlaundryapp/theme.dart';

import '../pages/layanan/layanan_edit_page.dart';

class LayananCard extends StatefulWidget {
  final LayananModel? layanan;
  final bool selected;
  const LayananCard(this.selected, this.layanan, {super.key});

  @override
  State<LayananCard> createState() => _LayananCardState();
}

class _LayananCardState extends State<LayananCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.selected) {
          TransaksiProvider transaksiProvider =
              Provider.of<TransaksiProvider>(context, listen: false);
          transaksiProvider.addItem(widget.layanan!);
          Navigator.pop(context);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LayananEditPage(widget.layanan!)));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.layanan!.profilePhotoUrl!,
              height: 50,
            ),
            SizedBox(
              width: large,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.layanan!.name!,
                      style: secondaryTextStyle,
                    ),
                  ),
                  Text(
                    'Rp ${widget.layanan!.price}',
                    style: secondaryTextStyle.copyWith(fontSize: small),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
