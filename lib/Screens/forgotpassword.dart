import 'package:flutter/material.dart';
import 'package:temp_daily_app/Animations/FadeAnimation.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotState();
  }
}

class ForgotState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/forgotback.png'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 220.0),
          child: Form(
              child: Column(
            children: <Widget>[
              FadeAnimation(
                  1.0,
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.8),
                          ),
                          hintText: "New Password"),
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              FadeAnimation(
                  1.0,
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.8),
                          ),
                          hintText: "Confirm Password"),
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              FadeAnimation(
                  1.0,
                  Center(
                    child: Container(
                      width: 180.0,
                      child: MaterialButton(
                        color: Colors.white,
                        textColor: Colors.cyan,
                        elevation: 5.0,
                        height: 45.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          //navigate();
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(101, 210, 255, 1)),
                        ),
                      ),
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
