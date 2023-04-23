import 'package:flutter/material.dart';

import 'main_page/contacts_page/contacts_page.dart';
import 'main_page/favourites_page/favouties_page.dart';

class MainPage extends StatefulWidget {
  final int? initialPage;

  static const routeName = "main-page";

  const MainPage({Key? key, this.initialPage}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.initialPage ?? 0;
    super.initState();
  }

  onBack() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedIndex: currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Contacts',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_border_outlined),
              label: 'Favourites',
            ),
          ],
        ),
        body: getIndex());
  }

  getIndex() {
    if (currentIndex == 0) {
      return const ContactsPage();
    } else if (currentIndex == 1) {
      return const FavouritesPage();
    } else {
      return Container();
    }
  }
}
