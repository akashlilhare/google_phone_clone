import 'package:flutter/material.dart';
import 'package:houzeo_sample/model/user_model.dart';
import 'package:houzeo_sample/pages/main_page/contacts_page/update_contact_form.dart';
import 'package:houzeo_sample/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';

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
                color: const Color(0xff1968D3),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Color(0xff1968D3), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    buildContactInfo() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Contact info",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Icon(Icons.phone_outlined),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "+91 - ${user.phone}",
                  style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 9,
            ),
            Row(
              children: [
                const   Icon(Icons.email_outlined),
                const   SizedBox(
                  width: 18,
                ),
                Text(
                  user.email,
                  style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const     SizedBox(
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
                icon:const Icon(Icons.edit_outlined)),
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
                icon: const Icon(Icons.delete_outlined)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: color,
                child: Text(
                  user.firstName[0].toUpperCase(),
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const  SizedBox(
                height: 40,
              ),
              Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(fontSize: 28),
              ),
              const   SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: .8,
                color: Colors.grey.shade400,
              ),
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: .8,
                color: Colors.grey.shade400,
              ),
              const  SizedBox(
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
