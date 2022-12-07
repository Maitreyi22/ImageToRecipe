import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 350, left: 30, right: 30),
              child: Text(
                "OOPs! " + "\n" + "Sorry the recipe does not exist. ",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFD78915),
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
