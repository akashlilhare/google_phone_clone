import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: const[
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(
              width: 18,
            ),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Spacer(),
          ],
        ));
  }
}
