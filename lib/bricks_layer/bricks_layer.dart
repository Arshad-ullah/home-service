import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeclean/bricks_layer/bricksLayerprofile.dart';
import 'package:homeclean/customerRegister.dart';

class BricksLayer extends StatefulWidget {
  @override
  _BricksLayerState createState() => _BricksLayerState();
}

class _BricksLayerState extends State<BricksLayer> {
  var value = 'BricksLayer';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => User(value: value)));
              },
              child: Text(
                'Registor',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('$value').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.red,
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                snapshot.data.docs[index]['ImageUrl']),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(
                            snapshot.data.docs[index]['Name'],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BricksLayerProfile(
                                          username: value,
                                          number: index,
                                        )));
                          },
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Image(
                          image: NetworkImage(
                              snapshot.data.docs[index]['ImageUrl']),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
