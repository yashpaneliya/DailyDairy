import 'package:flutter/material.dart';
import 'package:temp_daily_app/Animations/FadeAnimation.dart';
import 'package:temp_daily_app/Screens/forgotpassword.dart';

class otp_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return otp_state();
  }
}

class otp_state extends State<otp_page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/OTPVerification.png'),
            fit: BoxFit.fill
          )
      ),
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.8),
                                ),
                                hintText: "Enter Mobile"),
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    FadeAnimation(
                        1.0,
                        Container(
                          width: 150.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.8),
                                ),
                                hintText: "Enter OTP"),
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ForgotPasswordPage();
                                    }));
                              },
                              child: Text(
                                'Verify',
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