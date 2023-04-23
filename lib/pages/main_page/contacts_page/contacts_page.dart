import 'package:flutter/material.dart';
import 'package:houzeo_sample/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../widget/call_detail_tile.dart';
import 'add_contact_form.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.getAllContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        appBar: AppBar(title: const Text("Contacts Page")),
        floatingActionButton: userProvider.isLoading
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return const AddContactForm();
                      });
                },
                label: const Text("New Contact"),
                icon: const Icon(Icons.add),
              ),
        body: userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...userProvider.userList
                        .map((user) => CallDetailTile(
                              isFavourite: false,
                              user: user,
                              idx: userProvider.userList.indexOf(user),
                            ))
                        .toList()
                  ],
                ),
              ),
      );
    });
  }
}
