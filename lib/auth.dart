import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:connectivity/connectivity.dart';
import 'package:projectapp/ReciepePage.dart';
import 'package:projectapp/dashboard.dart';

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

  void signOut() {
    _handleSignOut();
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return DashBoard(user, signOut);
    } else {
      return SafeArea(
          child: Stack(
        children: [
          Positioned(
              top: 100,
              left: 32,
              child: Text(
                "Welcome!",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700]),
              )),
          Positioned(
              top: 155,
              left: 32,
              child: Text(
                "A place to find all the food you can possibly \nimagine.",
                style: TextStyle(
                  fontSize: 16.8,
                  color: Colors.grey[700],
                ),
              )),
          Positioned(
              top: 190,
              left: 90,
              child: SizedBox(
                height: 410,
                child: Image.asset('images/noodlesimg.png'),
              )),
          Positioned(
              top: 650,
              width: 227,
              left: 78,
              height: 68,
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
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.red[700],
                      //elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              //height: 40,
                              child: Image.asset(
                                'images/googleicon.png',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Login from Google',
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
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
