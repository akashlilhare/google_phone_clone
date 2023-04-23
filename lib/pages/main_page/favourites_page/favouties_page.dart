import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../widget/call_detail_tile.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.getFavouritesContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        appBar: AppBar(title: const Text("Favourites Contacts")),
        body: userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : userProvider.favouriteList.isEmpty
                ? const Center(
                    child: Text("No one added in favourite List"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...userProvider.favouriteList
                            .map((user) => CallDetailTile(
                                isFavourite: true,
                                user: user,
                                idx: Provider.of<UserProvider>(context)
                                    .favouriteList
                                    .indexOf(user)))
                            .toList()
                      ],
                    ),
                  ),
      );
    });
  }
}
