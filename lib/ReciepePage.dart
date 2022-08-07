import 'dart:convert';

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
  // String? get name => null;

  // get age => null;

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
                height: 32,
                margin: const EdgeInsets.only(top: 0, left: 30),
                child: const SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(3),
                    label: Text(
                      'Easy',
                      style: TextStyle(fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                height: 32,
                margin: const EdgeInsets.only(top: 0, left: 15),
                child: const SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(3),
                    label: Text(
                      'Beverage',
                      style: TextStyle(fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                height: 32,
                margin: const EdgeInsets.only(top: 0, left: 15),
                child: const SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(3),
                    label: Text(
                      '5k cal',
                      style: TextStyle(fontSize: 14, color: Color(0xFFD78915)),
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
            child: const Text(
              "Coffee powder - 1 teaspoon"
              "\n"
              "Milk -  1 Cup"
              "\n"
              "Water - 1 Cup"
              "\n"
              "Sugar - 2 teaspoon",
              style: TextStyle(
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
                height: 32,
                margin: const EdgeInsets.only(top: 10, left: 30, bottom: 10),
                child: const SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(3),
                    label: Text(
                      'Serves 1',
                      style: TextStyle(fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
              Container(
                height: 32,
                margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                child: const SizedBox(
                  child: Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(3),
                    label: Text(
                      '5 mins',
                      style: TextStyle(fontSize: 14, color: Color(0xFFD78915)),
                    ), //Text
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 30, right: 38),
            child: const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\n When an unknown printer took \na galley of type and scrambled it to make a type specimen book.\n It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(
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
                  height: 45,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _launchURLBigBasket,
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD78915),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Order Grocery',
                      // style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _launchURLZomato,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(
                            width: 1, color: Color(0xFFD78915)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
