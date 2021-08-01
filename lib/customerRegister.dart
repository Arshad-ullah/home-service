import 'package:flutter/material.dart';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeclean/Tailor/tailor.dart';
import 'package:homeclean/barber/barber.dart';
import 'package:homeclean/bricks_layer/bricks_layer.dart';
import 'package:homeclean/bridesmaids/bridesmaids.dart';
import 'package:homeclean/cook/cook.dart';
import 'package:homeclean/driver/driver.dart';
import 'package:homeclean/furniture_movers/furnitur_makers.dart';
import 'package:homeclean/gardena/gardena.dart';
import 'package:homeclean/goldsmith/goldsmith.dart';
import 'package:homeclean/hairstylist/hairstlist.dart';
import 'package:homeclean/house_boy/house_boy.dart';
import 'package:homeclean/house_help/househelp.dart';
import 'package:homeclean/house_painter/house_painter.dart';
import 'package:homeclean/internet_man/internet_men.dart';
import 'package:homeclean/iron_welder/iron_welder.dart';
import 'package:homeclean/massager/massage.dart';
import 'package:homeclean/mechanics/mechanics.dart';
import 'package:homeclean/movers/mover.dart';
import 'package:homeclean/part_dj/partydj.dart';
import 'package:homeclean/party_planner/party_planner.dart';
import 'package:homeclean/private_security/private_security.dart';
import 'package:homeclean/property_movers/propertymover.dart';
import 'package:homeclean/security/security.dart';
import 'package:homeclean/wedding_planner/wedingplanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class User extends StatefulWidget {
  var value;
  User({this.value});
  @override
  _UserState createState() => _UserState(value);
}

class _UserState extends State<User> {
  var value;
  _UserState(this.value);

  TextEditingController edEmail = TextEditingController();
  TextEditingController edPassword = TextEditingController();
  TextEditingController edPhone = TextEditingController();
  TextEditingController edName = TextEditingController();
  TextEditingController edLocation = TextEditingController();

  TextEditingController edSalary = TextEditingController();
  TextEditingController edSkill = TextEditingController();

  String _name, _email, _password, _phone, _location, _salary, _skill;

  File image;
  var imageUrl;
  bool isloading = false;

  final auth = FirebaseAuth.instance;

  Future creatUser() async {
    try {
      isloading = true;
      final user = await auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .whenComplete(() {
        _addData();
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  void _addData() async {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.doc('$value/$_name');

    final ref = FirebaseStorage.instance.ref().child('$_name');

    var url = await ref.getDownloadURL();

    setState(() {
      imageUrl = url;
    });

    Map<String, String> data = <String, String>{
      "Name": "$_name",
      "Email": "$_email",
      "Phone": "$_phone",
      "Location": "$_location",
      "Salary": "$_salary",
      "Skill": "$_skill",
      "Password": "$_password",
      "ImageUrl": "$imageUrl" //to store the image url in firebase storage
    };
    documentReference.set(data).whenComplete(() {
      switch (value) {
        case 'Tailor':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Tailor()));
          break;

        case 'Gardena':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Gardena()));
          break;
        case 'HouseHelp':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HouseHelp()));
          break;
        case 'Massage':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Massage()));
          break;
        case 'Driver':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Driver()));

          break;
        case 'Security':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Security()));
          break;

        case 'Cook':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Cook()));
          break;

        case 'PartyPlanner':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PartyPlanner()));
          break;
        case 'PartyDj':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PartyDj()));

          break;
        case 'Bridesmaids':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Bridesmaid()));
          break;
        case 'WeddingPlanner':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => WeddingPlanner()));
          break;

        case 'Movers':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Movers()));
          break;
        case 'PropertyMover':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PropertyMover()));

          break;
        case 'Furniture':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Furniture()));

          break;

        case 'GoldMith':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => GoldMith()));

          break;

        case 'PrivateSecurity':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PrivateSecurity()));

          break;

        case 'InternetMan':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => InternetMan()));

          break;
        case 'BricksLayer':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BricksLayer()));

          break;

        case 'Barber':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Barbar()));

          break;
        case 'HousePainter':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HousePainter()));

          break;
        case 'IronWelder':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => IronWelder()));

          break;

        case 'HouseBoy':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HouseBoy()));

          break;

        case 'Mechanics':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mechanics()));

          break;
        case 'Hairstylist':
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Hairstylist()));

          break;
      }
      setState(() {
        isloading = false;
      });
      edEmail.clear();
      edName.clear();
      edPassword.clear();
      edLocation.clear();
      edSalary.clear();
      edSkill.clear();
      edPhone.clear();
    });

    // documentReference.set(data).whenComplete(() {
    //   final Reference reference =
    //       FirebaseStorage.instance.ref().child('$_name');

    //   final UploadTask uploadTask = reference.putFile(image);
    //   uploadTask.whenComplete(() => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Login())));
    // });
  }

  // it is used for image from gallery

  final picker = ImagePicker();
  Future pickImage() async {
    var img = await picker.getImage(source: ImageSource.gallery);
    final Reference reference = FirebaseStorage.instance.ref().child('$_name');

    final UploadTask uploadTask = reference.putFile(File(img.path));
  }

  @override
  Widget build(BuildContext context) {
    return isloading
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
                actions: [
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Text(
                      'Add image',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.red,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        color: Colors.red,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'User Account',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  _email = value;
                                },
                                controller: edEmail,

                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                // onChanged: (value) {
                                //   _email = value;
                                // },
                                cursorColor: Colors.white,

                                //used for email validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  _name = value;
                                },
                                controller: edName,

                                decoration: InputDecoration(
                                  // hintText: 'Name',
                                  labelText: 'Name',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                // onChanged: (value) {
                                //   _email = value;
                                // },
                                cursorColor: Colors.white,
                                //used for name validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                onChanged: (value) {
                                  _password = value;
                                },
                                controller: edPassword,

                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'password',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.lock_open_outlined,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                cursorColor: Colors.white,
                                obscureText: true,
                                //used for password validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                onChanged: (value) {
                                  _phone = value;
                                },
                                controller: edPhone,

                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.white),

                                decoration: InputDecoration(
                                  labelText: 'Phone number',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                cursorColor: Colors.white,
                                //used for phone number validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                onChanged: (value) {
                                  _location = value;
                                },
                                controller: edLocation,

                                style: TextStyle(color: Colors.white),

                                decoration: InputDecoration(
                                  labelText: 'Location',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                cursorColor: Colors.white,
                                //used for phone number validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _salary = value;
                                },
                                controller: edSalary,

                                style: TextStyle(color: Colors.white),

                                decoration: InputDecoration(
                                  labelText: 'Salary/hr',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                cursorColor: Colors.white,
                                //used for phone number validation
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: TextFormField(
                                onChanged: (value) {
                                  _skill = value;
                                },
                                controller: edSkill,

                                style: TextStyle(color: Colors.white),

                                decoration: InputDecoration(
                                  labelText: 'Skill',
                                  errorStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.time_to_leave,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                cursorColor: Colors.white,
                                //used for phone number validation
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: RaisedButton(
                                onPressed: () {
                                  creatUser();
                                },
                                color: Colors.greenAccent,
                                child: Text('SIGN UP'),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
