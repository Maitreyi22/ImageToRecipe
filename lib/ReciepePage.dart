import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class ReciepePage extends StatefulWidget {
  GoogleSignInAccount user;
  String? predictedName;

  ReciepePage({Key? key, required this.predictedName, required this.user})
      : super(key: key);

  @override
  State<ReciepePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<ReciepePage> {
  bool isWorking = true;
  late String imageUrl;
  String? name;
  String? difficultyLevel;
  String? cuisine;
  String? calories;
  String? ingredients;
  String? serving;
  String? approxTime;
  String? recipe;
  var suggestions = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMyRecipe();
  }

  void readMyRecipe() async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.predictedName.toString())
        .get();

    setState(() {
      imageUrl = (documentSnapshot.data() as dynamic)['Image'];
      name = (documentSnapshot.data() as dynamic)['name'];
      difficultyLevel =
          (documentSnapshot.data() as dynamic)['difficulty level'];
      recipe = (documentSnapshot.data() as dynamic)['recipe'];
      cuisine = (documentSnapshot.data() as dynamic)['cuisine'];
      calories = (documentSnapshot.data() as dynamic)['calories'];
      ingredients = (documentSnapshot.data() as dynamic)['ingredients'];
      serving = (documentSnapshot.data() as dynamic)['serving'];
      approxTime = (documentSnapshot.data() as dynamic)['approx time'];
      recipe = (documentSnapshot.data() as dynamic)['recipe'];
      suggestions = (documentSnapshot.data() as dynamic)['suggestions'];
    });

    setState(() {
      isWorking = false;
    });
  }

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

  Widget _buildBody() {
    List<String>? result_ing = ingredients?.split('*');
    var stringList_ing = result_ing!.join(" \n\n");

    List<String>? result_rec = recipe?.split('*');
    var stringList_rec = result_rec!.join(" \n\n");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: isWorking
              ? CircularProgressIndicator()
              : Stack(children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 13, left: 17, bottom: 5),
                            alignment: Alignment.topLeft,
                            height: 30,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back, size: 29)),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 30, left: 265, bottom: 0),
                              alignment: Alignment.topLeft,
                              height: 22,
                              child: InkWell(
                                  // onTap: _wishlist,
                                  child: Image.asset("images/heart.png",
                                      color: Colors.black))),
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 30, right: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 30, right: 10),
                            // width: 120.0,
                            height: 40.0,
                            child: Text(
                              name!,
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
                      Container(
                        margin: const EdgeInsets.only(top: 0, left: 30),
                        child: Wrap(
                          spacing: 15,
                          children: [
                            SizedBox(
                              child: Chip(
                                avatar: Container(
                                  height: 17,
                                  child: ClipRRect(
                                    child: Image.asset('images/Difficulty.png'),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFD78915)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.all(4),
                                label: Text(
                                  // widget.difficultyLevel.toString(),
                                  difficultyLevel!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFD78915)),
                                ), //Text
                              ),
                            ),
                            SizedBox(
                              child: Chip(
                                avatar: Container(
                                  height: 17,
                                  child: ClipRRect(
                                    child: Image.asset('images/Cusine.png'),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFD78915)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.all(4),
                                label: Text(
                                  // widget.cuisine.toString(),
                                  cuisine!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFD78915)),
                                ), //Text
                              ),
                            ),
                            Container(
                              // margin: const EdgeInsets.only(top: 0, left: 15),
                              child: SizedBox(
                                child: Chip(
                                  avatar: Container(
                                    height: 17,
                                    child: ClipRRect(
                                      child: Image.asset('images/Calorie.png'),
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: Color(0xFFD78915)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  padding: const EdgeInsets.all(4),
                                  label: Text(
                                    // widget.difficultyLevel.toString(),
                                    calories!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xFFD78915)),
                                  ), //Text
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 35,
                        thickness: 2,
                        color: Color(0xFFF2F2F2),
                      ),
                      //Chip
                      Container(
                        margin:
                            const EdgeInsets.only(top: 0, left: 30, right: 40),
                        child: const Text(
                          "Ingredients\n",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Container(
                        margin:
                            const EdgeInsets.only(top: 0, left: 30, right: 28),
                        child: Text(
                          // widget.ingredients.toString(),
                          " $stringList_ing",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),

                      const Divider(
                        height: 0,
                        thickness: 2,
                        color: Color(0xFFF2F2F2),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 30),
                        child: const Text(
                          "Recipe",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 30, bottom: 10),
                            child: SizedBox(
                              child: Chip(
                                avatar: Container(
                                  height: 17,
                                  child: ClipRRect(
                                    child: Image.asset('images/Serves.png'),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFD78915)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.all(4),
                                label: Text(
                                  // widget.serving.toString(),
                                  serving!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFD78915)),
                                ), //Text
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 15, bottom: 10),
                            child: SizedBox(
                              child: Chip(
                                avatar: Container(
                                  height: 17,
                                  child: ClipRRect(
                                    child: Image.asset('images/clock.png'),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFD78915)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.all(4),
                                label: Text(
                                  // widget.approxTime.toString(),
                                  approxTime!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFD78915)),
                                ), //Text
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 30, right: 38),
                        child: Text(
                          // widget.recipe.toString(),
                          "$stringList_rec",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),

                      const Divider(
                        height: 30,
                        thickness: 2,
                        color: Color(0xFFF2F2F2),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 0, left: 30),
                        child: const Text(
                          "Recommendations for you",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 0, left: 30),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 220,
                                width: 190,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                // child: Text('image')))
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: FittedBox(
                                        child: Image(
                                          height: 210,
                                          width: 210,
                                          image: NetworkImage(suggestions[0]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 300,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        suggestions[1],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                  Positioned(
                    //constraints.biggest.height to get the height
                    // * .05 to put the position top: 5%
                    top: MediaQuery.of(context).size.height - 105,
                    child: Container(
                      height: 78,
                      width: 390,
                      color: Colors.grey[50],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
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
                            height: 50,
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
                  ),
                ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        Center(
            child: isWorking
                ? Container(
                    width: 200,
                    child: const LinearProgressIndicator(
                      backgroundColor: Color(0xFFD78915),
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      minHeight: 8,
                    ),
                  )
                : _buildBody()),
      ],
    );
  }
}
