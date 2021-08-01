import 'package:flutter/material.dart';
import 'package:homeclean/home.dart';
import 'package:homeclean/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  TextEditingController edEmail = TextEditingController();
  TextEditingController edName = TextEditingController();
  TextEditingController edPassword = TextEditingController();
  TextEditingController edPhone = TextEditingController();

  // This is used for animation.. start of animation
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }
  // end of animation

  //this is firbase part<begain>

  String _name, _email, _password, _phone;

  final auth = FirebaseAuth.instance;
  bool loading = false;
  Future createUser() async {
    try {
      setState(() {
        loading = true;
      });
      final user = auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .whenComplete(() {
        _addData();
      });
    } catch (e) {}
  }

  void _addData() async {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.doc('Customer/$_name');

    Map<String, String> data = <String, String>{
      "Name": "$_name",
      "Email": "$_email",
      "Phone Number": "$_phone",
      "Password": "$_password"
    };
    documentReference.set(data).whenComplete(() {
      Navigator.pop(context);
      edEmail.clear();
      edPassword.clear();
      edName.clear();
      edPhone.clear();
      setState(() {
        loading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  // ending point

  //this part is used for validation

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String validateEmail(value) {
    if (value.isEmpty) {
      return 'required email';
    } else {
      return null;
    }
  }

  String validatePassword(value) {
    if (value.isEmpty) {
      return 'required password';
    } else {
      return null;
    }
  }

  String validateName(value) {
    if (value.isEmpty) {
      return ' requred name';
    } else {
      return null;
    }
  }

  String validatePhone(value) {
    if (value.isEmpty) {
      return 'require phone number';
    } else {
      return null;
    }
  }

  void validate() {
    if (globalKey.currentState.validate()) {
      createUser();
    }
  }

  //end of validation

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return loading
              ? Container(
                  child: Scaffold(
                    backgroundColor: Colors.red,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 4.4,
                        ),
                        Text(
                          'loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Scaffold(
                  backgroundColor: Colors.deepOrangeAccent,
                  body: SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation.value * width, 0.0, 0.0),
                      child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.bottomLeft,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                child: Text(
                                  'Welcome,\nSign up to get started.',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Form(
                              key: globalKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    child: TextFormField(
                                      controller: edEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        errorStyle:
                                            TextStyle(color: Colors.black),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: Icon(
                                          Icons.alternate_email,
                                          color: Colors.white70,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      // onChanged: (value) {
                                      //   _email = value;
                                      // },
                                      cursorColor: Colors.white,

                                      validator:
                                          validateEmail, //used for email validation
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    child: TextFormField(
                                      controller: edName,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        // hintText: 'Name',
                                        labelText: 'Name',
                                        errorStyle:
                                            TextStyle(color: Colors.black),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white70,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      // onChanged: (value) {
                                      //   _email = value;
                                      // },
                                      cursorColor: Colors.white,
                                      validator:
                                          validateName, //used for name validation
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    child: TextFormField(
                                      controller: edPassword,
                                      // onChanged: (value) {
                                      //   _password = value;
                                      // },
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'password',
                                        errorStyle:
                                            TextStyle(color: Colors.black),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: Colors.white70,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      cursorColor: Colors.white,
                                      obscureText: true,
                                      validator:
                                          validatePassword, //used for password validation
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    child: TextFormField(
                                      controller: edPhone,
                                      // onChanged: (value) {
                                      //   _password = value;
                                      // },

                                      onChanged: (value) {
                                        _phone = value;
                                      },
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(color: Colors.white),

                                      decoration: InputDecoration(
                                        labelText: 'Phone number',
                                        errorStyle:
                                            TextStyle(color: Colors.black),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Colors.white70,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      cursorColor: Colors.white,
                                      validator:
                                          validatePhone, //used for phone number validation
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: RaisedButton(
                                      onPressed: () {
                                        validate();
                                      },
                                      color: Colors.lightGreen,
                                      splashColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.1)),
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn()));
                                        },
                                        child: Text(
                                          'SIGN IN',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ),
                  )),
                ));
        });
  }
}
