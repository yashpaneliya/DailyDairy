import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp_daily_app/Animations/FadeAnimation.dart';
import 'package:temp_daily_app/Screens/subscribeScreen.dart';
import 'package:temp_daily_app/users.dart';

import '../main.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onSignedIn;

  const RegisterPage({Key key, this.onSignedIn});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<RegisterPage> {
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();
  String email, password, name, surname, number, cpassword;
  bool passwordShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordShow = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/SignUp.png"), fit: BoxFit.fill)),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 120.0),
          child: Form(
              key: fkey,
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: 50.0,
                            padding: EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color.fromRGBO(22, 102, 225, 1)),
                                color: Colors.white),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8),
                                  ),
                                  hintText: "First Name"),
                              validator: (input) {
                                if (input.isEmpty) {
                                  return "Enter name";
                                }
                                return null;
                              },
                              onChanged: (input) => name = input,
                            ),
                          )),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                              child: Container(
                            height: 50.0,
                            padding: EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(22, 102, 225, 1)),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8),
                                  ),
                                  hintText: "Last Name"),
                              validator: (input) {
                                if (input.isEmpty) {
                                  return "Enter surname";
                                }
                              },
                              onChanged: (input) => surname = input,
                            ),
                          )),
                        ],
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeAnimation(
                      1.0,
                      Container(
                        height: 50.0,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(22, 102, 225, 1)),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(.8),
                              ),
                              hintText: "Email"),
                          validator: (input) {
                            if (input.isEmpty) {
                              return "Enter email";
                            }
                          },
                          onChanged: (input) => email = input,
                        ),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeAnimation(
                      1.0,
                      Container(
                        height: 50.0,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(22, 102, 225, 1)),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(.8),
                              ),
                              hintText: "Mobile"),
                          validator: (input) {
                            if (input.isEmpty && input.length != 10) {
                              return "Enter number";
                            }
                          },
                          onChanged: (input) => number = input,
                        ),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeAnimation(
                      1.0,
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(
                                color: Color.fromRGBO(22, 102, 225, 1))),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: passwordShow,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordShow
                                      ? Icons.remove_red_eye
                                      : Icons.lock,
                                  color: Color.fromRGBO(22, 102, 225, 1),
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordShow = !passwordShow;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.8),
                                  fontFamily: 'R'),
                              hintText: "Password"),
                          onChanged: (input) => password = input,
                        ),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeAnimation(
                      1.0,
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(
                                color: Color.fromRGBO(22, 102, 225, 1))),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value != password) {
                              return 'Confirm password must be same as password';
                            }
                            return null;
                          },
                          obscureText: passwordShow,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordShow
                                      ? Icons.remove_red_eye
                                      : Icons.lock,
                                  color: Color.fromRGBO(22, 102, 225, 1),
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordShow = !passwordShow;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(.8),
                              ),
                              hintText: "Confirm Password"),
                          onChanged: (input) => password = input,
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  FadeAnimation(
                      1.0,
                      Center(
                        child: Container(
                          width: 180.0,
                          child: MaterialButton(
                            color: Color.fromRGBO(22, 102, 225, 1),
                            textColor: Colors.white,
                            elevation: 5.0,
                            height: 45.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              if (fkey.currentState.validate()) {
                                signup();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return radio();
                                }));
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  FadeAnimation(
                    1.0,
                    FlatButton(
                      padding: EdgeInsets.only(left: 5.0),
                      textColor: Color.fromRGBO(22, 102, 225, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text(
                        'Already have an account ? Log In',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> signup() async {
    final formstate = fkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        var map = <dynamic, dynamic>{};
        await users(uid: user.user.uid).addUserData(
            name, surname, email, number, " ", " ", " ", true, 0, null);

        Firestore.instance
            .collection('cart')
            .document(user.user.uid)
            .setData({'product': map});
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
    }
  }
}
