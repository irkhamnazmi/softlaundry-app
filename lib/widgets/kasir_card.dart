import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/kasir_model.dart';
import 'package:softlaundryapp/pages/kasir_edit_page.dart';
import 'package:softlaundryapp/theme.dart';

class KasirCard extends StatefulWidget {
  final KasirModel kasir;
  const KasirCard(this.kasir, {super.key});

  @override
  State<KasirCard> createState() => _KasirCardState();
}

class _KasirCardState extends State<KasirCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    KasirEditPage(widget.kasir)));
      },
      child: Container(
        padding: EdgeInsets.only(top: large, bottom: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          children: [
            Image.network(
              widget.kasir.profilePhotoUrl ?? '',
              height: 50,
            ),
            SizedBox(
              width: large,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.kasir.name ?? '',
                    style: secondaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${widget.kasir.createdAt!} WIB',
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
