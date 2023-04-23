import 'package:flutter/material.dart';
import 'package:houzeo_sample/constants/constant.dart';

import '../model/user_model.dart';
import '../pages/main_page/contacts_page/contact_detail_page.dart';

class CallDetailTile extends StatelessWidget {
  final User user;
  final int idx;
  final bool isFavourite;

  const CallDetailTile(
      {Key? key,
      required this.user,
      required this.idx,
      required this.isFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 25,
      onTap: () {
        if (!isFavourite) {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
            return ContactDetailPage(
              color: Colors.primaries[(user.firstName.length + 10) % 17],
              idx: idx,
            );
          }));
        }
      },
      leading: CircleAvatar(
        backgroundColor: Colors.primaries[(user.firstName.length + 10) % 17],
        radius: 24,
        child: Text(
          user.firstName[0].toUpperCase(),
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      title: Text(
        "${user.firstName} ${user.lastName}",
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.phone_outlined,
          color: Colors.black.withOpacity(.7),
        ),
        onPressed: () {
          Constants().makePhoneCall(user.phone);
        },
      ),
    );
  }
}
