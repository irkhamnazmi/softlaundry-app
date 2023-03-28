import 'package:flutter/material.dart';
import 'package:softlaundryapp/theme.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/member-edit');
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
                  '01/01/2023',
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
