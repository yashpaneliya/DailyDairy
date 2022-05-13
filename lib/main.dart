import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:temp_daily_app/Screens/homepage.dart';
import 'package:temp_daily_app/authentication/auth.dart';
import 'package:temp_daily_app/authentication/auth_provider.dart';
import 'package:temp_daily_app/authentication/root.dart';
import 'Animations/FadeAnimation.dart';
import 'Screens/register.dart';

void main() {
  runApp(AuthProvider(
    auth: Auth(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Dairy',
      home: rootpage(),
      theme: ThemeData(
        fontFamily: 'Varela',
      ),
    ),
  ));
}

class LoginPage extends StatefulWidget {
  final VoidCallback onSignedIn;

  const LoginPage({Key key, this.onSignedIn});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  bool passwordShow;
  String email, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordShow = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/Login.png"), fit: BoxFit.fill)),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(
                  1.9,
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
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
                                return 'Please enter email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8),
                                    fontFamily: 'R'),
                                hintText: "Email"),
                            onChanged: (input) => email = input,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
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
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                  1.8,
                  Center(
                    child: Container(
                      width: 180.0,
                      child: MaterialButton(
                        color: Color.fromRGBO(22, 102, 225, 1),
                        elevation: 5.0,
                        height: 44.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            signIn();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 15.0,
              ),
              FadeAnimation(
                  1.8,
                  Container(
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 80.0,
                          ),
                          FlatButton(
                            textColor: Color.fromRGBO(22, 102, 225, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterPage();
                              }));
                            },
                            child: Text(
                              'Don\'t have an Account? Sign up',
                              style: TextStyle(
                                color: Color.fromRGBO(22, 102, 225, 1),
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
      FirebaseUser user2 = await FirebaseAuth.instance.currentUser();
      print(user2);
      if (user2 != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {

      }
    }
  }
}
