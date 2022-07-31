import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReciepePage extends StatefulWidget {
  const ReciepePage({Key? key}) : super(key: key);

  @override
  State<ReciepePage> createState() => _ReciepePageState();
}

class _ReciepePageState extends State<ReciepePage> {
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
          Container(
            margin: const EdgeInsets.only(top: 16, left: 17),
            alignment: Alignment.topLeft,
            height: 30,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, size: 29)),
          ),
          // Container(
          //   margin: const EdgeInsets.only(left: 135),
          //   child: Text(
          //     'Your Recipe',
          //     style: TextStyle(
          //       fontSize: 23,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.deepOrange[800],
          //     ),
          //   ),
          // ),
          Container(
            // margin: const EdgeInsets.only(top: 20, left: 35, right: 35),

            height: 180.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: const DecorationImage(
                    image: NetworkImage(
                      "https://i.picsum.photos/id/1060/5598/3732.jpg?hmac=31kU0jp5ejnPTdEt-8tAXU5sE-buU-y1W1qk_BsiUC8",
                    ),
                    fit: BoxFit.cover)),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 38, right: 10),
                // width: 120.0,
                height: 40.0,
                child: Text(
                  "Coffee",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange[800]),
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
          Container(
            margin: const EdgeInsets.only(top: 5, left: 38),
            child: const Text(
              "Ingredients",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 38),
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
          Container(
            margin: const EdgeInsets.only(top: 10, left: 38),
            child: const Text(
              "Recipe",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 38, right: 38),
            child: const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. When an unknown printer took a galley of type and scrambled it to make a type specimen book.\n It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _launchURLBigBasket,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[700]!,
                        side: BorderSide(
                            width: 1, color: Colors.deepOrange[700]!),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Order Grocery',
                      // style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _launchURLZomato,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                            width: 1, color: Colors.deepOrange[700]!),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'Order Food',
                      style: TextStyle(color: Colors.deepOrange[700]!),
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
