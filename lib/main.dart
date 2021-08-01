import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'splashscreen.dart';

void main(List<String> args) async {
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MaterialApp(
      title: 'Home Clean',
      debugShowCheckedModeBanner: false,
      home: Myapp(),
    ));
  }
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Splash(),
      ),
    );
  }
}
