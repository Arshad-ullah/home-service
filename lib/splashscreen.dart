import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Home Cleaning',
                  style: GoogleFonts.lakkiReddy(
                      fontSize: 30.4, color: Colors.white)),
            ),
            SizedBox(
              height: 4.4,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.red,
              color: Colors.white,
            ),
            SizedBox(
              height: 4.4,
            ),
            Text('loading...', style: GoogleFonts.abel(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
