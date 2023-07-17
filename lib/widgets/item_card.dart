import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:softlaundryapp/models/transaksi_item_model.dart';
import 'package:softlaundryapp/providers/transaksi_provider.dart';
import 'package:softlaundryapp/theme.dart';

class ItemCard extends StatelessWidget {
  final TransaksiItemModel? item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController weightController = TextEditingController();
    weightController.text = item!.weight!.toStringAsFixed(0);
    TransaksiProvider transaksiProvider =
        Provider.of<TransaksiProvider>(context);
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: large, vertical: 11),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: tertiaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item!.layanan!.name!,
                          style: secondaryTextStyle.copyWith(
                              fontSize: large, fontWeight: semiBold),
                        ),
                        Text(
                          'Rp ${item!.layanan!.price!.toStringAsFixed(0)} /kg x ${item!.weight!.toStringAsFixed(0)}',
                          // 'Rp ${widget.item.layanan!.price}/kg x ${widget.item.weight}',
                          style: tertiaryTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: extraSmall),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: large,
                  ),
                  Text(
                    'Rp ${item!.subPrice!.toStringAsFixed(0)}',
                    // 'Rp ${widget.item.layanan!.price}/kg x ${widget.item.weight}',
                    style: primaryTextStyle.copyWith(
                        fontSize: extralarge, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    transaksiProvider.addWeight(item!.id!);
                  },
                  child: Image.asset(
                    'assets/up.png',
                    height: 14,
                  ),
                ),
                SizedBox(height: large),
                Container(
                  alignment: Alignment.center,
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: tertiaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        double v = double.parse(value);
                        if (v <= 0) {
                          transaksiProvider.removeItem(item!.layanan!.id!);
                        } else {
                          transaksiProvider.editWeight(item!.layanan!.id!, v);
                        }
                      }
                    },
                    style: secondaryTextStyle,
                    decoration: InputDecoration.collapsed(
                        hintText: '0', hintStyle: tertiaryTextStyle),
                  ),
                ),
                SizedBox(height: large),
                GestureDetector(
                  onTap: () {
                    transaksiProvider.reduceWeight(item!.id!);
                  },
                  child: Image.asset(
                    'assets/down.png',
                    height: 14,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
