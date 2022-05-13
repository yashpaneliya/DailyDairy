import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp_daily_app/Screens/SubscribedPage.dart';
import 'package:temp_daily_app/Screens/profile.dart';
import 'package:toast/toast.dart';
import 'Settings.dart';
import 'cart.dart';
import 'home.dart';

var map = <dynamic, dynamic>{};
int sum = 0;

class ProductDetails extends StatefulWidget {
  final assetPath, price, name, desc;

  const ProductDetails(
      {Key key, this.assetPath, this.price, this.name, this.desc});

  @override
  _ProductDetailsState createState() =>
      _ProductDetailsState(assetPath, price, name, desc);
}

class _ProductDetailsState extends State<ProductDetails> {
  final assetPath, price, name, desc;
  int counter = 1;
  bool select = true;
  int currentTab = 0; // to keep track of active tab index
  int temp = 1;
  var textController = new TextEditingController();
  final List<Widget> screens = [
    Home(),
    ProfilePage(),
    SubscribedPlan(),
    Settings(),
  ]; // to store nested tabs

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  Future<void> getcart() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('cart').document(uid).get();
    DocumentSnapshot snapshotCart =
        await Firestore.instance.collection('users').document(uid).get();
    setState(() {
      map = snapshot.data['product'];
      sum = snapshotCart.data['CartValue'];
    });
  }

  _ProductDetailsState(this.assetPath, this.price, this.name, this.desc);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcart();
    textController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(22, 102, 225, 1),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Daily Dairy',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black.withOpacity(.6)),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Product Details',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Hero(
            tag: assetPath,
            child: Image.network(
                assetPath),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                "₹ $price /-",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Varela',
                    fontSize: 20.0,
                    color: Colors.black),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                "$name",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 20.0,
                    color: Colors.black.withOpacity(.8)),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                "$desc",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(.8)),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  iconSize: 30.0,
                  onPressed: () {
                    setState(() {
                      if (counter != 1) {
                        counter = int.parse(textController.text);
                        counter--;
                        textController.text = counter.toString();
                      }
                    });
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  width: 30.0,
//                  child: TextField(
//                    keyboardType: TextInputType.number,
//                    controller: textController,
//                    cursorColor: Colors.black,
//                  ),
                child: Text(
                  '$counter'
                ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      counter = int.parse(textController.text);
                      counter++;
                      if (counter > 5) {
                        counter = 5;
                        Toast.show(
                            'You can not order more than 5 at once!!', context,
                            textColor: Colors.white,
                            backgroundColor: Colors.black);
                      }
                      textController.text = counter.toString();
                    });
                  },
                  iconSize: 30.0,
                )
              ],
            ),
          ),
          Center(
              child: Container(
            width: 200.0,
            height: 45.0,
            child: MaterialButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Color.fromRGBO(22, 102, 225, 1),
              onPressed: () {
                setState(() {
                  if (counter > 5) {
                    counter = 5;
                    textController.text='5';
                    Toast.show(
                        'You can not order more than 5 at once!!', context,
                        textColor: Colors.white,
                        backgroundColor: Colors.black);
                  }
                  else
                    {
                      map['$name'] = counter.toString();
                      int itemPrice = int.parse(this.price);
                      sum = sum + (counter * itemPrice);
                      putdata();
                      Toast.show("Added to Cart", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.CENTER,
                          backgroundColor: Color.fromRGBO(22, 102, 225, .8));
                    }
                });

              },
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        },
        backgroundColor: Color.fromRGBO(22, 102, 225, 1),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//      bottomNavigationBar: BottomAppBar(
//        shape: CircularNotchedRectangle(),
//        notchMargin: 10,
//        child: Container(
//          height: 60,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Row(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  SizedBox(
//                    width: 30.0,
//                  ),
//                  MaterialButton(
//                    minWidth: 40,
//                    onPressed: () {
//                      setState(() {
//                        currentScreen =
//                            Home(); // if user taps on this homepage tab will be active
//                        currentTab = 0;
//                      });
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(
//                          Icons.home,
//                          color: currentTab == 0
//                              ? Color.fromRGBO(22, 102, 225, 1)
//                              : Colors.grey,
//                        ),
//                        Visibility(
//                            visible: currentTab == 0 ? true : false,
//                            child: Text(
//                              'Home',
//                              style: TextStyle(
//                                color: currentTab == 0
//                                    ? Color.fromRGBO(22, 102, 225, 1)
//                                    : Colors.grey,
//                              ),
//                            ))
//                      ],
//                    ),
//                  ),
//                  MaterialButton(
//                    minWidth: 40,
//                    onPressed: () {
//                      setState(() {
//                        currentScreen =
//                            ProfilePage(); // if user taps on this dashboard tab will be active
//                        currentTab = 1;
//                      });
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(
//                          Icons.account_box,
//                          color: currentTab == 1
//                              ? Color.fromRGBO(22, 102, 225, 1)
//                              : Colors.grey,
//                        ),
//                        Visibility(
//                          visible: currentTab == 1 ? true : false,
//                          child: Text(
//                            'Profile',
//                            style: TextStyle(
//                              color: currentTab == 1
//                                  ? Color.fromRGBO(22, 102, 225, 1)
//                                  : Colors.grey,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  )
//                ],
//              ),
//
//              // Right Tab bar icons
//
//              Row(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  MaterialButton(
//                    minWidth: 40,
//                    onPressed: () {
//                      setState(() {
//                        currentScreen =
//                            SubscribedPlan(); // if user taps on this dashboard tab will be active
//                        currentTab = 2;
//                      });
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(
//                          Icons.playlist_add_check,
//                          color: currentTab == 2
//                              ? Color.fromRGBO(22, 102, 225, 1)
//                              : Colors.grey,
//                        ),
//                        Visibility(
//                          visible: currentTab == 2 ? true : false,
//                          child: Text(
//                            'Subscribed\n      Plan',
//                            style: TextStyle(
//                              color: currentTab == 2
//                                  ? Color.fromRGBO(22, 102, 225, 1)
//                                  : Colors.grey,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  MaterialButton(
//                    minWidth: 40,
//                    onPressed: () {
//                      setState(() {
//                        currentScreen =
//                            Settings(); // if user taps on this dashboard tab will be active
//                        currentTab = 3;
//                      });
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(
//                          Icons.settings,
//                          color: currentTab == 3
//                              ? Color.fromRGBO(22, 102, 225, 1)
//                              : Colors.grey,
//                        ),
//                        Visibility(
//                          visible: currentTab == 3 ? true : false,
//                          child: Text(
//                            'Settings',
//                            style: TextStyle(
//                              color: currentTab == 3
//                                  ? Color.fromRGBO(22, 102, 225, 1)
//                                  : Colors.grey,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    width: 30.0,
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//      ),
    );
  }

  Future putdata() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var product = <String, Object>{};
    product['product'] = map;
    Firestore.instance.collection('cart').document(uid).updateData(product);
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'product': map});
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'CartValue': sum});
  }
}
