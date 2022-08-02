import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectapp/ReciepePage.dart';
import 'package:provider/provider.dart';
import 'package:projectapp/registrationuser.dart';
<<<<<<< HEAD
import 'dart:math' as math;
=======
import 'package:http/http.dart' as http;
>>>>>>> 4e3b87dc7d848b3ad438289834a0b3056de39cf5

class DashBoard extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount user;

  DashBoard(this.user, this.signOut);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isUser = false;
  bool isWorking = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  File? selectedImage;
  String? message = '';

  onUploadImage() async {

    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://2a9f-123-201-215-121.in.ngrok.io/predict'),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: $request");
    final res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    message = resJson["message"];
    setState(() {});
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('users')
          .doc(widget.user.email.toString())
          .get();
      print(documentSnapshot.data());
      if (documentSnapshot.data() != null) {
        setState(() {
          isUser = true;
        });
      }
      setState(() {
        isWorking = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
  }

  Widget _buildBody() {
    if (isUser == false) {
      return RegistrationUser(widget.user, widget.signOut);
    } else {
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
                child: SizedBox(
              width: 600,
              height: 230,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.deepOrange[800]),
              ),
            )),
            Positioned(
              top: 20,
              left: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      widget.signOut();
                      widget.user.clearAuthCache();
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    width: 75,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 75,
                  ),
                  const Text(
                    "Wishlist",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 170,
                left: 80,
                child: Transform.rotate(
                  angle: -math.pi / 2,
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('images/cookhat.png')),
                )),
            Positioned(
                top: 130,
                left: 132,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 64,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage(widget.user.photoUrl.toString()),
                  ),
                )),
            Positioned(
              left: MediaQuery.of(context).size.width - 345,
              top: 270,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(),
                    child: const Text(
                      'Hello, ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 27),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(),
                    child: Text(
                      "${widget.user.displayName}!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[800],
                          fontSize: 27),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 440,
              left: MediaQuery.of(context).size.width - 371,
              child: Container(
                width: 345,
                height: 59,
                child: InkWell(
                  onTap: () {
                    selectedImage == null
                    ? onUploadImage()
                    : Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReciepePage()),
                    );
                  },
                  child: Card(
                    //elevation: 30,
                    shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.deepOrange[800],
                    child: const Center(
                      child: Text(
                        'Take a photo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: MediaQuery.of(context).size.width - 371,
              child: Container(
                width: 345,
                height: 59,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReciepePage()),
                    );
                  },
                  child: Card(
                    //elevation: 30,
                    shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.deepOrange[800],
                    child: const Center(
                      child: Text(
                        'Upload a photo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 580,
              left: MediaQuery.of(context).size.width - 371,
              child: Container(
                width: 345,
                height: 59,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegistrationUser(widget.user, widget.signOut)),
                    );
                  },
                  child: Card(
                    //elevation: 30,
                    shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.deepOrange[800],
                    child: const Center(
                      child: Text(
                        'Upload a photo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
