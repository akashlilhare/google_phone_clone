import 'package:flutter/material.dart';
import 'package:houzeo_sample/model/user_model.dart';
import 'package:houzeo_sample/pages/main_page/update_contact_form.dart';
import 'package:houzeo_sample/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';

class ContactDetailPage extends StatelessWidget {
  final int idx;
  final Color color;

  const ContactDetailPage({
    Key? key,
    required this.idx,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).userList[idx];
    Constants constants = Constants();

    buildActionButton(
        {required String title,
        required IconData icon,
        required Function onTap}) {
      return Expanded(
        child: InkWell(
          onTap: () => onTap(),
          child: Column(
            children: [
              Icon(
                icon,
                color: Color(0xff1968D3),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Color(0xff1968D3), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    buildContactInfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              "Contact info",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(Icons.phone_outlined),
                SizedBox(
                  width: 18,
                ),
                Text(
                  "+91 - ${user.phone}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              children: [
                Icon(Icons.email_outlined),
                SizedBox(
                  width: 18,
                ),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      );
    }

    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return UpdateContactForm(
                          user: user,
                        );
                      });
                },
                icon: Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: () async {
                  userProvider.updateFavourite(
                      user: User(
                          isFavourite: !user.isFavourite,
                          email: user.email,
                          firstName: user.firstName,
                          phone: user.phone,
                          userId: user.userId,
                          lastName: user.lastName),
                      context: context);
                },
                icon: Icon(
                  user.isFavourite ? Icons.star : Icons.star_border_outlined,
                  color: user.isFavourite ? Colors.blue : null,
                )),
            IconButton(
                onPressed: () {
                  userProvider.deleteContact(user: user, context: context);
                },
                icon: Icon(Icons.delete_outlined)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: color,
                child: Text(
                  user.firstName[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "${user.firstName} ${user.lastName}",
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: .8,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildActionButton(title: "Call", icon: Icons.call_outlined,onTap: (){
                    constants.makePhoneCall(user.phone);
                  }),
                  buildActionButton(title: "Text", icon: Icons.message_rounded,onTap: (){
                    constants.showToast(message: "Opening Text massage");
                  }),
                  buildActionButton(
                      title: "Video", icon: Icons.video_camera_back_outlined,onTap: (){
                    constants.showToast(message: "Launching video camera");
                  }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: .8,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 20,
              ),
              buildContactInfo(),
            ],
          ),
        ),
      );
    });
  }
}
