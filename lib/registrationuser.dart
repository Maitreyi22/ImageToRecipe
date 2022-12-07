import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectapp/dashboard.dart';
import 'package:projectapp/main.dart';

class RegistrationUser extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount user;

  RegistrationUser(this.user, this.signOut);

  @override
  State<RegistrationUser> createState() => _RegistrationUserState();
}

class _RegistrationUserState extends State<RegistrationUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final successnackbar =
      const SnackBar(content: Text('Registered Successfully!'));
  final nameWarning =
      const SnackBar(content: Text('Please Enter a User Name!'));
  final mobileWarning =
      const SnackBar(content: Text('Please Enter a valid contact number!'));
  final addressWarning =
      const SnackBar(content: Text('Please enter your Address! '));
  final dobWarning =
      const SnackBar(content: Text('Please enter a valid Date of Birth!'));
  DateTime selectedDate = DateTime.now();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      nameController.text = widget.user.displayName.toString();
    });
  }

  int _radioValue = 0;

  void _handleRadioValueChange(value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0, left: 0, right: 200),
                  alignment: Alignment.topLeft,
                  height: 30,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                            widget.signOut(), widget.user.clearAuthCache());
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, size: 35)),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 0, top: 34),
                  child: const Text(
                    'Enter Personal Details',
                    style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFFD78915),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),

                Container(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundImage:
                          NetworkImage(widget.user.photoUrl.toString()),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  // child: Text(
                  //   " Enter Name",
                  //   style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                  // ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name',
                      hintStyle: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      suffixIcon: Icon(Icons.person, size: 30),
                      // border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(30),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //),
                Container(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: mobileController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Contact Number',
                      hintStyle: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      suffix: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Container(
                  height: 20,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                    ),
                    const Text('Gender : ', style: TextStyle(fontSize: 17.0)),
                    Radio(
                      value: 0,
                      activeColor: Color(0xFFD78915),
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    const Text(
                      'Male',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 1,
                      activeColor: Colors.black,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    const Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextField(
                    maxLines: 2,
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Address',
                      hintStyle: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      suffix: Icon(Icons.location_city, size: 30),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Container(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 20,
                    ),
                    const Text(
                      "Select your DOB  : ",
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(
                      width: 20,
                    ),
                    Container(
                      width: 120,
                      child: ElevatedButton(
                        //shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(30)),
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ), // Refer step 3
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      height: 46,
                      width: 330,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          switch (validateFields()) {
                            case 0:
                              _registerUser();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(successnackbar);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DashBoard(widget.user, widget.signOut)),
                              );
                              break;

                            case 1:
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(nameWarning);
                              break;
                            case 2:
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(mobileWarning);
                              break;
                            case 3:
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(addressWarning);
                              break;
                            case 4:
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dobWarning);
                              break;
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 15.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  int validateFields() {
    if (nameController.text.isEmpty) {
      return 1;
    } else if (mobileController.text.length != 10) {
      return 2;
    } else if (addressController.text.length < 5) {
      return 3;
    } else if (selectedDate.year > DateTime.now().year - 10) {
      return 4;
    } else {
      return 0;
    }
  }

  void _registerUser() async {
    try {
      await firestore
          .collection('users')
          .doc(widget.user.email.toString())
          .set({
        'name': nameController.text.toString(),
        'gender': _radioValue == 0 ? 'Male' : 'Female',
        'address': addressController.text.toString(),
        'dob': selectedDate,
        'mobile': mobileController.text.toString(),
      });
    } catch (e) {
      print(e);
    }
  }
}
