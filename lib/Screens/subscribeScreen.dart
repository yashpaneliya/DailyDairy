import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

String val;
String address;
List<bool> day = [false, false, false, false, false, false, false];
bool b=false;

class radio extends StatefulWidget {
  @override
  radioState createState() => radioState();
}

class radioState extends State<radio> {
  int amul_gold = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: (Text(
              "Subscription Plans",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 102, 225, 1)),
            )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
                child: Card(
                  elevation: 10.0,
                  child: Image.asset(
                    'images/weekly.png',
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                ),
                onPressed: () {
                  val = "weekly";
                  bottom(context, val);
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
                child: Card(
                  elevation: 10.0,
                  child: Image.asset(
                    'images/monthly.png',
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                ),
                onPressed: () {
                  val = "monthly";
                  bottom(context, val);
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
                child: Card(
                  elevation: 10.0,
                  child: Image.asset(
                    'images/yearly.png',
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                ),
                onPressed: () {
                  val = "yearly";
                  bottom(context, val);
                }),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width - 80.0,
            height: 45.0,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              elevation: 10.0,
              color: Color.fromRGBO(22, 102, 225, 1),
              onPressed: () {
                val = "custom";
                setState(() {
                  b=true;
                });
                bottom(context, val);
              },
              child: Text(
                'Custom Plan',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        },
        child: Text("Skip"),
        backgroundColor: Colors.blue[400],
      ),
    );
  }

  bottom(context, String plan) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return sheet();
        });
  }
}

class sheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sheetstate();
  }
}

class sheetstate extends State<sheet> {
  int amul_gold = 0,
      amul_shakti = 0,
      amul_taaza = 0,
      gokul = 0,
      govardhan = 0,
      mahi = 0;
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();

  Widget checkbox(String title, bool boolvalue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolvalue,
          onChanged: (value) {
            setState(() {
              switch (title) {
                case "M":
                  day[0] = value;
                  break;
                case "Tu":
                  day[1] = value;
                  break;
                case "W":
                  day[2] = value;
                  break;
                case "Th":
                  day[3] = value;
                  break;
                case "F":
                  day[4] = value;
                  break;
                case "St":
                  day[5] = value;
                  break;
                case "Sn":
                  day[6] = value;
                  print(day[6]);
                  break;
              }
            });
          },
        )
      ],
    );
  }

  Future<void> customData() async {
    Map<String, bool> arr = {};
    int i = 0;
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    if (day[0] == true) {
      arr['M'] = true;
      i++;
    }
    if (day[1] == true) {
      arr['Tu'] = true;
      i++;
    }
    if (day[2] == true) {
      arr['W'] = true;
      i++;
    }
    if (day[3] == true) {
      arr['M'] = true;
      i++;
    }
    if (day[4] == true) {
      arr['F'] = true;
      i++;
    }
    if (day[5] == true) {
      arr['St'] = true;
      i++;
    }
    if (day[6] == true) {
      arr["Sn"] = true;
      i++;
    }
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'Days': arr});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(),
          child: Text(
            "Select Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: fkey,
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(22, 102, 225, 1)),
                    hoverColor: Color.fromRGBO(22, 102, 225, 1),
                    hintText: 'Enter Address'),
                onChanged: (input) {
                  address = input;
                },
                validator: (input) {
                  if (input.isEmpty) {
                    return "Enter Address";
                  }
                }),
          ),
        ),
        Visibility(
          visible:(b==true)? true:false,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    checkbox("M", day[0]),
                    checkbox("Tu", day[1]),
                    checkbox("W", day[2]),
                    checkbox("Th", day[3]),
                    checkbox("F", day[4]),
                    checkbox("St", day[5]),
                    checkbox("Sn", day[6]),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/gold.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Amul Gold\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:28/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 38,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (amul_gold != 0) {
                      amul_gold = amul_gold - 1;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$amul_gold",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    amul_gold = amul_gold + 1;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/taaza.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Amul Shakti\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:26/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 26,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (amul_shakti != 0) {
                      amul_shakti = amul_shakti - 1;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$amul_shakti",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    amul_shakti = amul_shakti + 1;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/taaza.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Amul Taaza\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:22/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 26,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (amul_taaza != 0) {
                      amul_taaza--;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$amul_taaza",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    amul_taaza++;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/mother_dairy.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Gokul\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:26/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 43,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (gokul != 0) {
                      gokul--;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$gokul",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    gokul++;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/govardahan.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Govardhan\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:26/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 32,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (govardhan != 0) {
                      govardhan--;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$govardhan",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    govardhan++;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                child: Image.asset("images/Milk/mahi.png"),
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 29,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Mahi\n(500ML)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "Price:26/-",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 42,
              ),
              MaterialButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (mahi != 0) {
                      mahi--;
                    }
                  });
                },
              ),
              Container(
                child: Text(
                  "$mahi",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              MaterialButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    mahi++;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: MaterialButton(
              color: Color.fromRGBO(22, 102, 225, 1),
              child: Text(
                'Subscribe',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              onPressed: () {
                if (fkey.currentState.validate()) {
                  putData();
                  customData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                }
              }),
        ),
      ],
    );
  }

  Future<void> putData() async {
    int sum = 0;
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var map = <String, String>{};
    if (amul_gold != 0) {
      sum = sum + amul_gold * 28;
      map['Amul Gold'] = "$amul_gold";
    }
    if (amul_shakti != 0) {
      sum = sum + amul_shakti * 24;
      map['Amul Shakti'] = amul_shakti.toString();
    }
    if (amul_taaza != 0) {
      sum = sum + amul_taaza * 26;
      map['Amul Taaza'] = amul_taaza.toString();
    }
    if (gokul != 0) {
      sum = sum + gokul * 25;
      map['Gokul'] = gokul.toString();
    }
    if (govardhan != 0) {
      sum = sum + govardhan * 28;
      map['Govardhan'] = govardhan.toString();
    }
    if (mahi != 0) {
      sum = sum + mahi * 25;
      map['Mahi'] = mahi.toString();
    }
    var product = <String, Object>{};
    product['product'] = map;
    await Firestore.instance
        .collection('product')
        .document(uid)
        .setData(product);
    //update data
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'Plan': val});
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'Address': address, 'Bill': sum.toString()});
  }
}
