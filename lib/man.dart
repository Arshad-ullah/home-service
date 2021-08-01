import 'dart:convert';

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
import 'package:homeclean/signIn.dart';
import 'package:homeclean/wedding_planner/wedingplanner.dart';
import 'Tailor/tailor.dart';
import 'gardena/gardena.dart';

class ManScreen extends StatefulWidget {
  @override
  _ManScreenState createState() => _ManScreenState();
}

class _ManScreenState extends State<ManScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/data.json'),
            builder: (context, snapshot) {
              var mydata = json.decode(snapshot.data.toString());
              return GridView.builder(
                itemCount: 24,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    child: Stack(
                      children: [
                        Material(
                          child: Image.asset('assets/img($index).jpg'),
                          elevation: 9,
                          shadowColor: Colors.red,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Text(
                                  "${mydata['$index']['name']}\n\n\$${mydata['$index']['Hr']}/hr"),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              child: Text('click here'),
                              onPressed: () {
                                switch (index) {
                                  case 0:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Tailor()));
                                    break;

                                  case 1:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Gardena()));
                                    break;
                                  case 2:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => HouseHelp()));
                                    break;
                                  case 3:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Massage()));

                                    break;
                                  case 4:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Driver()));
                                    break;

                                  case 5:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Security()));
                                    break;

                                  case 6:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Cook()));
                                    break;
                                  case 7:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PartyPlanner()));
                                    break;

                                  case 8:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PartyDj()));
                                    break;
                                  case 9:
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Bridesmaid()));
                                    break;

                                  case 10:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WeddingPlanner()));
                                    break;

                                  case 11:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Movers()));
                                    break;
                                  case 12:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyMover()));
                                    break;
                                  case 13:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Furniture()));
                                    break;
                                  case 14:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GoldMith()));
                                    break;
                                  case 15:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivateSecurity()));
                                    break;

                                  case 16:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InternetMan()));
                                    break;
                                  case 17:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BricksLayer()));
                                    break;

                                  case 18:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mechanics()));
                                    break;
                                  case 19:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Hairstylist()));
                                    break;

                                  case 20:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Barbar()));
                                    break;

                                  case 21:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HousePainter()));
                                    break;

                                  case 22:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IronWelder()));
                                    break;

                                  case 23:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HouseBoy()));
                                    break;
                                }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("${mydata['$index']['job']}"),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
