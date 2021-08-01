import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeclean/home.dart';
import 'package:homeclean/signUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  // This for animation

  String _email, _password;

  TextEditingController edEmail = TextEditingController();
  TextEditingController edPassword = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool loading = false;

  final auth = FirebaseAuth.instance;

  Future<void> sign_In() async {
    try {
      setState(() {
        loading = true;
      });
      final user = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        edEmail.clear();
        edPassword.clear();
        setState(() {
          loading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Not sign in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            timeInSecForIosWeb: 1);
      }
    } catch (e) {
      print(e);
    }
  }

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

  void validate() {
    if (globalKey.currentState.validate()) {
      sign_In();
    } else {
      print("error");
    }
  }

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
                    appBar: AppBar(
                      backgroundColor: Colors.red,
                    ),
                    backgroundColor: Colors.red,
                    body: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Center(
                            //   child: Container(
                            //     color: Colors.white,
                            //     //padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                            //     child: Image.asset('assets/cleaning.jpeg'),
                            //   ),
                            // ),
                            Center(
                              child: Container(
                                // padding: EdgeInsets.only(top: 15),
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('assets/cleaning.jpeg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                animation.value * width,
                                0.0,
                                0.0,
                              ),
                              child: Form(
                                key: globalKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextFormField(
                                        controller: edEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: 'Email Address',
                                          errorStyle:
                                              TextStyle(color: Colors.black),
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
                                        onChanged: (value) {
                                          _email = value;
                                        },
                                        cursorColor: Colors.white,
                                        validator: validateEmail,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextFormField(
                                        controller: edPassword,
                                        onChanged: (value) {
                                          _password = value;
                                        },
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          errorStyle:
                                              TextStyle(color: Colors.black),
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
                                        validator: validatePassword,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: RaisedButton(
                                        onPressed: () {
                                          validate();
                                        },
                                        child: Text(
                                          'SIGN IN',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.lightGreenAccent,
                                        splashColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
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
                                                        SignUp()));
                                          },
                                          child: Text(
                                            'SIGN Up',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        bottomShet(context);
                                      },
                                      child: Text(
                                        'SIGN In with others?',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }

  bottomShet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(
            children: [
              Container(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login with',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'SIGN IN with Google',
                          style: (TextStyle(color: Colors.white)),
                        )),
                    SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'SIGN IN with Facebook',
                          style: (TextStyle(color: Colors.white)),
                        )),
                    SizedBox(
                      height: 14,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'SIGN IN with Phone Number',
                        style: (TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
