import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_daily_app/Animations/FadeAnimation.dart';
import 'package:temp_daily_app/Screens/subscribeScreen.dart';
import 'package:toast/toast.dart';

Map<dynamic, dynamic> product;
String plan;
List<dynamic> namelist;
List<dynamic> qlist;
String bill;
bool statusFirebase;
bool status;
String stat = 'Pause Plan';
enum ConfirmAction { CANCEL, ACCEPT }
class SubscribedPlan extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SubscribedPlan> {
  final db = Firestore.instance;
  DateFormat dateformat = new DateFormat.Hm();

  void getData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    DocumentSnapshot snapshot =
        await db.collection('users').document(uid).get();
    DocumentSnapshot snap2 =
        await db.collection(('product')).document(uid).get();
    setState(() {
      bill = snapshot.data['Bill'];
      plan = snapshot.data['Plan'];
      product = snap2.data['product'];
      namelist = product.keys.toList();
      qlist = product.values.toList();
      statusFirebase = snapshot.data['Status'];
    });
    print(namelist);
  }

Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('About changes'),
        content: const Text(
            'Your plan status will change from tomorrow morning!!'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              DateTime now = DateTime.now();
              DateTime open = dateformat.parse("05:00");
              open = new DateTime(now.year, now.month, now.day,
                  open.hour, open.minute);
              DateTime close = dateformat.parse("10:00");
              close = new DateTime(now.year, now.month, now.day,
                  close.hour, close.minute);
              if (now.isAfter(open) && now.isBefore(close)) {
                Toast.show(
                    "You can't change your plan status \n between 5:00AM to 10:00 AM",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
              } else {
                updateStatus();
                setState(() {
                  (statusFirebase == true)
                      ? stat = 'Pause Plan'
                      : stat = 'Activate Plan';
                });
              }
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}

  Future<void> updateStatus() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    DocumentSnapshot snapshot =
        await db.collection('users').document(uid).get();
    statusFirebase = snapshot.data['Status'];
    if (statusFirebase == true) {
      status = false;
      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'Status': status});
    } else {
      status = true;
      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'Status': status});
    }
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
        body: (plan == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        image: DecorationImage(
                            image: AssetImage('images/noplan.png'),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100.0,
                    height: 45.0,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      elevation: 5.0,
                      color: Color.fromRGBO(22, 102, 225, 1),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return radio();
                        }));
                      },
                      child: Text(
                        'Subscribe Plan',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              )
            : FadeAnimation(
                1.0,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 50.0,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 10.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'Current Plan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(22, 102, 225, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 70.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: (plan == 'weekly')
                                  ? AssetImage('images/weekly.png')
                                  : ((plan == 'monthly')
                                      ? (AssetImage('images/monthly.png'))
                                      : ((plan == 'yearly')
                                          ? AssetImage('images/yearly.png')
                                          : AssetImage('images/custom.png')))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          color: Colors.transparent,
                          elevation: 10.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 15.0, left: 15.0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(22, 102, 225, 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Products',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'Product name',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                    Text('Quantity',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    print(namelist),
                                    print(qlist)
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.0)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text('Total (Per Day)',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white)),
                                    Text('₹$bill/-',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white))
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width - 100.0,
                      height: 45.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 5.0,
                        color: Color.fromRGBO(22, 102, 225, 1),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return radio();
                          }));
                        },
                        child: Text(
                          'Change Plan',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    )),
                    Center(
                        child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: MediaQuery.of(context).size.width - 100.0,
                      height: 45.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 5.0,
                        color: Color.fromRGBO(22, 102, 225, 1),
                        onPressed: () {
                          _asyncConfirmDialog(context);
                        },
                        child: Text(
                          stat,
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ))
                  ],
                )));
  }

  Widget print(List<dynamic> list) {
    String len = "";
    for (int i = 0; i < list.length; i++) {
      len = len + list[i] + "\n";
    }
    return Text(
      len,
      style: TextStyle(fontSize: 15.0, color: Colors.white),
    );
  }
}
