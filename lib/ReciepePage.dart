import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class ReciepePage extends StatefulWidget {
  String name;

  ReciepePage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ReciepePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<ReciepePage> {
  _launchURLZomato() async {
    var url = Uri.parse("https://www.zomato.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLBigBasket() async {
    var url = Uri.parse("https://www.bigbasket.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 13, left: 17, bottom: 5),
                alignment: Alignment.topLeft,
                height: 30,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, size: 29)),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 25, left: 265, bottom: 5),
                  alignment: Alignment.topLeft,
                  height: 22,
                  child: Image.asset("images/heart.png", color: Colors.black)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const Image(
                image: NetworkImage(
                    'https://i.picsum.photos/id/1060/5598/3732.jpg?hmac=31kU0jp5ejnPTdEt-8tAXU5sE-buU-y1W1qk_BsiUC8'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 30, right: 10),
                // width: 120.0,
                height: 40.0,
                child: Text(
                  widget.name.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                height: 13.0,
                margin: const EdgeInsets.only(top: 0),
                alignment: Alignment.center,
                // child: const Text("Veg",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold, color: Colors.green)),
                child: Image.asset('images/veg_icon.png'),
              )
            ],
          ),

          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, left: 30),
                child: SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(4),
                    label: Text(
                      // widget.difficultyLevel.toString(),
                      "Easy",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 15),
                child: SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(4),
                    label: Text(
                      // widget.cuisine.toString(),
                      "Beverage",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 15),
                child: SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(4),
                    label: Text(
                      // widget.difficultyLevel.toString(),
                      "5k cal",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 35,
            thickness: 2,
            color: Color(0xFFF2F2F2),
          ),
          //Chip
          Container(
            margin: const EdgeInsets.only(top: 0, left: 30),
            child: const Text(
              "Ingredients",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30),
            child: Text(
              // widget.ingredients.toString(),
              "coffeee,milk",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),

          const Divider(
            height: 35,
            thickness: 2,
            color: Color(0xFFF2F2F2),
          ),

          Container(
            margin: const EdgeInsets.only(top: 0, left: 30),
            child: const Text(
              "Recipe",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 30, bottom: 10),
                child: SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(4),
                    label: Text(
                      // widget.serving.toString(),
                      "1 serve",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                child: SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(4),
                    label: Text(
                      // widget.approxTime.toString(),
                      "5 minutes",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 38),
            child: Text(
              // widget.recipe.toString(),
              "Milk pour",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const Divider(
            height: 35,
            thickness: 2,
            color: Color(0xFFF2F2F2),
          ),

          Container(
            height: 80,
            color: Colors.grey,
            margin: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 47,
                  width: 183,
                  child: ElevatedButton(
                    onPressed: _launchURLBigBasket,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: const Color(0xFFD78915),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Order Grocery',
                      // style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 47,
                  width: 183,
                  child: ElevatedButton(
                    onPressed: _launchURLZomato,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white,
                        side: const BorderSide(
                            width: 1, color: Color(0xFFD78915)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Order Food',
                      style: TextStyle(color: Color(0xFFD78915)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
