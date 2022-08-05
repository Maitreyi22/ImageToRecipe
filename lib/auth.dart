import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:connectivity/connectivity.dart';
import 'package:projectapp/ReciepePage.dart';
import 'package:projectapp/dashboard.dart';
import 'dart:math' as math;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    setState(() {});
  }

  // Future<void> _handleSignOut() => _googleSignIn.signOut();

  Widget _buildBody() {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return DashBoard(user, signOut);
    } else {
      return SafeArea(
          child: Stack(
        children: [
          Positioned(
              top: 55,
              left: 230,
              child: Transform.rotate(
                angle: math.pi / 6,
                child: SizedBox(
                  height: 75,
                  child: Image.asset(
                    'images/Ice cream.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          Positioned(
              top: 150,
              left: 110,
              child: Transform.rotate(
                angle: math.pi / 30,
                child: SizedBox(
                  height: 50,
                  child: Image.asset(
                    'images/Fries.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          Positioned(
              top: 170,
              right: 46,
              child: Transform.rotate(
                angle: math.pi / 30,
                child: SizedBox(
                  height: 39,
                  child: Image.asset(
                    'images/Pizza.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          const Positioned(
              top: 200,
              left: 100,
              child: Text(
                "What",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),

          const Positioned(
              top: 200,
              left: 200,
              child: Text(
                "Name",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD78915)),
              )),

          const Positioned(
              top: 250,
              left: 40,
              child: Text(
                "A place to find all the food you can possibly \n                              imagine!",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),

          Positioned(
              top: 220,
              left: 55,
              child: Transform.rotate(
                angle: math.pi / 7,
                child: SizedBox(
                  height: 85,
                  child: Image.asset(
                    'images/Burger.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          Positioned(
              top: 330,
              right: 70,
              child: Transform.rotate(
                angle: -math.pi / 6,
                child: SizedBox(
                  height: 80,
                  child: Image.asset(
                    'images/Fries.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          Positioned(
              top: 440,
              left: 50,
              child: Transform.rotate(
                angle: math.pi / 30,
                child: SizedBox(
                  height: 59,
                  child: Image.asset(
                    'images/Pizza.png',
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              )),

          Positioned(
            top: 520,
            right: 80,
            child: SizedBox(
              height: 80,
              child: Image.asset(
                'images/Bubble Tea.png',
                color: Colors.white.withOpacity(0.10),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),

          Positioned(
            top: 617,
            left: 80,
            child: SizedBox(
              height: 72,
              child: Image.asset(
                'images/Ice cream.png',
                color: Colors.white.withOpacity(0.10),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),

          // Positioned(
          //     top: 190,
          //     left: 90,
          //     child: SizedBox(
          //       height: 410,
          //       child: Image.asset('images/noodlesimg.png'),
          //     )),
          Positioned(
              top: 670,
              width: 350,
              left: 20,
              height: 70,
              child: Center(
                widthFactor: 2.2,
                child: DelayedDisplay(
                  delay: const Duration(milliseconds: 100),
                  child: InkWell(
                    onTap: () {
                      _handleSignIn();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Color(0xFFD78915),
                      //elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            SizedBox(
                              width: 30,
                              height: 40,
                              child: Image.asset(
                                'images/googleicon.png',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Login with Google',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
