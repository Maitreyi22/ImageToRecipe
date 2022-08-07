import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectapp/ReciepePage.dart';
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

// class ImageFile {
//   //final File? selectedImage;
//   String? message = '';

//   //ImageFile(this.selectedImage);
//   ImageFile(this.message);
// }

class _DashBoardState extends State<DashBoard> {
  bool isUser = false;
  bool isWorking = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  File? selectedImage;
  String? message = '';

  onUploadImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    var request = http.MultipartRequest(
      'POST',

      // Uri.parse('https://aec8-124-66-170-211.in.ngrok.io/predict'),

      Uri.parse('http://10.0.2.2:5001/predict'),
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
    message = resJson["name"];
    setState(() {});
    // ignore: use_build_context_synchronously
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => ReciepePage(message!)));
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
                      Navigator.pop(context);
                      widget.signOut();
                      widget.user.clearAuthCache();
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
              top: 640,
              left: MediaQuery.of(context).size.width - 370,
              right: MediaQuery.of(context).size.width - 370,
              child: Container(
                width: 275,
                height: 60,
                child: InkWell(
                  onTap: () {
                    onUploadImage();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReciepePage(name: message!);
                    }));
                  },
                  child: Card(
                    //elevation: 30,
                    shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    color: Color(0xFFD78915),
                    child: const Center(
                      // child: Column(
                      //   children: <Widget>[
                      //     selectedImage == null
                      //         ? const Text(' \n Take a photo',
                      //             style: const TextStyle(color: Colors.white))
                      //         : Text(message!)
                      //   ],
                      // ),
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
              left: MediaQuery.of(context).size.width - 370,
              right: MediaQuery.of(context).size.width - 370,
              child: Container(
                width: 275,
                height: 60,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ReciepePage()),
                    // );
                  },
                  child: Card(
                    //elevation: 30,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFD78915)),
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

            // Positioned(
            //   top: 580,
            //   left: MediaQuery.of(context).size.width - 371,
            //   child: Container(
            //     width: 345,
            //     height: 59,
            //     child: InkWell(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   RegistrationUser(widget.user, widget.signOut)),
            //         );
            //       },
            //       child: Card(
            //         //elevation: 30,
            //         shape: RoundedRectangleBorder(
            //             //side: BorderSide(color: Colors.white),
            //             borderRadius: BorderRadius.circular(10)),
            //         color: Colors.deepOrange[800],
            //         child: const Center(
            //           child: Text(
            //             'Upload a photo',
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
