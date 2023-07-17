import 'package:flutter/material.dart';
import 'package:softlaundryapp/models/member_model.dart';
import 'package:softlaundryapp/pages/member_edit_page.dart';
import 'package:softlaundryapp/theme.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;
  const MemberCard(this.member, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MemberEditPage(member)));
      },
      child: Container(
        padding: EdgeInsets.only(top: large, bottom: large),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tertiaryColor))),
        child: Row(
          children: [
            Image.network(
              member.profilePhotoUrl ?? '',
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
                    member.name ?? '',
                    style: secondaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${member.createdAt!} WIB',
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
