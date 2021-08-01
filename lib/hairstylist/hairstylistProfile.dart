import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeclean/signUp.dart';

class HairStylistProfile extends StatefulWidget {
  var username;
  int number;
  HairStylistProfile({this.username, this.number});

  @override
  _HairStylistProfileState createState() =>
      _HairStylistProfileState(username, number);
}

class _HairStylistProfileState extends State<HairStylistProfile> {
  var username;
  int number;
  _HairStylistProfileState(this.username, this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xff555555),
        appBar: AppBar(
            title: Text('User Data'), backgroundColor: Color(0xff555555)),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(username).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Scaffold(
              backgroundColor: Color(0xff555555),
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Stack(alignment: Alignment.center, children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'User Profile',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 35.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 130,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot.data.docs[number]['ImageUrl'])),
                            // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(color: Colors.white, width: 3),
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          snapshot.data.docs[number]['Name'],
                          style: TextStyle(color: Colors.white, fontSize: 23.0),
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: 20,
                          indent: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text('Email',
                                    style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                  snapshot.data.docs[number]['Email'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ListTile(
                                leading: Text('Phone',
                                    style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                  snapshot.data.docs[number]['Phone'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ListTile(
                                leading: Text('Skill',
                                    style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                  snapshot.data.docs[number]['Skill'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ListTile(
                                leading: Text('Location',
                                    style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                  snapshot.data.docs[number]['Location'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ListTile(
                                leading: Text('Salary',
                                    style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                  snapshot.data.docs[number]['Salary'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              'order',
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.white,
                            splashColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
