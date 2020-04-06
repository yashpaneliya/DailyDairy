import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String name = ' ';
String surname = ' ', email = ' ', mobile = ' ', address = ' ';
final db = Firestore.instance;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  DocumentSnapshot snapshot;

  void getData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    print(uid);
    snapshot = await db.collection('users').document(uid).get();
    setState(() {
      name = snapshot.data['Name'];
      surname = snapshot.data['Surname'];
      email = snapshot.data['Email'];
      mobile = snapshot.data['Number'];
      address = snapshot.data['Address'];
    });
    print(name);
    print(surname);
    print(email);
    print(mobile);
    print(address);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width-90.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/UserProfile.png'),
                fit: BoxFit.fill
              )
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "$name".toUpperCase(),
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color.fromRGBO(22, 102, 225, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "$surname".toUpperCase(),
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color.fromRGBO(22, 102, 225, 1),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50.0,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(22, 102, 225, 1))),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Color.fromRGBO(22, 102, 225, 1),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '+91$mobile',
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.mail,
                  color: Color.fromRGBO(22, 102, 225, 1),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '$email',
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(22, 102, 225, 1),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100.0,
                  child: Text((address==' ')?'--Not Added--':'$address',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, fontSize: 24.0)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
