import 'package:flutter/material.dart';
import 'package:houzeo_sample/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/user_model.dart';

class AddContactForm extends StatefulWidget {
  const AddContactForm({super.key});

  @override
  State<AddContactForm> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<AddContactForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Create contact"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<UserProvider>(builder: (context, userProvider, _) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      User user = User(
                          email: emailController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          userId: DateTime.now().millisecondsSinceEpoch.toString(),
                      isFavourite: false);
                      userProvider.saveContact(user: user, context: context);
                    }
                  },
                  child: userProvider.isLoading
                      ?const SizedBox(
                          height: 20,
                          width: 20,
                          child:  CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Save"));
            }),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: borderDecoration,
                          icon: const Icon(Icons.person),
                          hintText: 'First Name',
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: borderDecoration,
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.length != 10) {
                          return 'Mobile Number must be of 10 digit';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: borderDecoration,
                        icon: const Icon(Icons.phone),
                        hintText: 'Phone Number',
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern);
                        if (value != null && !regex.hasMatch(value)) {
                          return 'Enter Valid Email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: borderDecoration,
                        icon: const Icon(Icons.email),
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
