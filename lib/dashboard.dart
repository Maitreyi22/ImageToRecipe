import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectapp/ReciepePage.dart';
import 'package:projectapp/auth.dart';
import 'package:provider/provider.dart';
import 'package:projectapp/registrationuser.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class DashBoard extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount user;

  DashBoard(this.user, this.signOut, {Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isUser = false;
  bool isWorking = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  File? selectedImage;
  String name = '';

  onUploadImage(source) async {
    var image = await ImagePicker().pickImage(source: source);
    selectedImage = File(image!.path);
    var request = http.MultipartRequest(
      'POST',

      Uri.parse('https://7de3-124-66-171-222.in.ngrok.io/predict'),

      // Uri.parse('http://10.0.2.2:5001/predict'),
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

    // name = resJson["name"];

    setState(() {
      name = resJson["name"];
    });

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReciepePage(
        predictedName: name,
        user: widget.user,
      );
    }));
  }

  onCameraImage(source) async {
    var image = await ImagePicker()
        .pickImage(imageQuality: 90, source: ImageSource.camera);
    selectedImage = File(image!.path);
    var request = http.MultipartRequest(
      'POST',

      Uri.parse('https://7de3-124-66-171-222.in.ngrok.io/predict'),

      // Uri.parse('http://10.0.2.2:5001/predict'),
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

    // name = resJson["name"];

    // setState(() {
    //   isWorking = false;
    // });

    setState(() {
      name = resJson["name"];
    });

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReciepePage(predictedName: name, user: widget.user);
    }));
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('users')
          .doc(widget.user.email.toString())
          .get();
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
            const Positioned(
                child: SizedBox(
              width: 600,
              height: 250,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            )),
            Positioned(
              top: 20,
              left: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          widget.signOut(), widget.user.clearAuthCache());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            width: 21,
                            height: 30,
                            child: Image.asset(
                              'images/logouticon.png',
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 240,
                  ),
                  SizedBox(
                      width: 21,
                      height: 30,
                      child: Image.asset(
                        'images/heart.png',
                      )),
                ],
              ),
            ),
            Positioned(
              top: 190,
              left: 40,
              child: SizedBox(
                height: 50,
                child: Image.asset(
                  'images/Fries.png',
                  color: Colors.grey[600],
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 90,
              child: SizedBox(
                height: 50,
                child: Image.asset(
                  'images/Bubble Tea.png',
                  color: Colors.grey[600],
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 170,
              child: SizedBox(
                height: 52,
                child: Image.asset(
                  'images/Burger.png',
                  color: Colors.grey[600],
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Positioned(
              top: 122,
              right: 90,
              child: SizedBox(
                height: 52,
                child: Image.asset(
                  'images/Ice cream.png',
                  color: Colors.grey[600],
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Positioned(
                top: 194,
                right: 45,
                child: Transform.rotate(
                  angle: math.pi / 30,
                  child: SizedBox(
                    height: 38,
                    child: Image.asset(
                      'images/Pizza.png',
                      color: Colors.grey[600],
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                )),
            Positioned(
                top: 190,
                left: 140,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 54,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(widget.user.photoUrl.toString()),
                  ),
                )),
            Positioned(
              left: MediaQuery.of(context).size.width - 370,
              top: 300,
              child: const Text(
                'Hi, ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD78915),
                    fontSize: 27),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - 370,
              top: 295,
              child: Text(
                "\n${widget.user.displayName}!",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 27),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - 370,
              top: 400,
              child: Container(
                  width: 340,
                  margin: const EdgeInsets.only(),
                  child: Image.asset('images/middle_component.png')),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - 330,
              top: 615,
              child: Container(
                width: 340,
                margin: const EdgeInsets.only(),
                child: Text(
                  'Select any option to search the food item.',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey[600]),
                ),
              ),
            ),
            Positioned(
              // top: 640,
              top: 640,
              bottom: 105,
              left: MediaQuery.of(context).size.width - 370,
              right: MediaQuery.of(context).size.width - 370,
              child: Container(
                width: 275,
                height: 60,
                child: InkWell(
                  onTap: () {
                    onCameraImage(ImageSource.camera);
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    color: Color(0xFFD78915),
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
              top: 703,
              bottom: 44,
              left: MediaQuery.of(context).size.width - 370,
              right: MediaQuery.of(context).size.width - 370,
              child: Container(
                width: 275,
                height: 60,
                child: InkWell(
                  onTap: () {
                    onUploadImage(ImageSource.gallery);
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFFD78915)),
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Upload a photo',
                        style: TextStyle(color: Color(0xFFD78915)),
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
      child: isWorking
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.all(5),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color(0xFFD78915),
                      )),
                ),
              ],
            )
          : _buildBody(),
    ));
  }
}
