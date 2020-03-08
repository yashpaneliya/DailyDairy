import 'package:flutter/material.dart';
import 'package:temp_daily_app/Screens/feedback.dart';
import 'package:temp_daily_app/authentication/auth.dart';
import 'package:temp_daily_app/authentication/auth_provider.dart';
import 'package:temp_daily_app/main.dart';

class Settings extends StatefulWidget {
  final VoidCallback onSignedOut;

  const Settings({Key key, this.onSignedOut});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Settings.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.edit),
                      FlatButton(
                        child: Text(
                          'Raise a complain',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => feedbackPage()
                          ));
                        },
                      ),
                    ],
                  )),
            ),
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.map),
                      FlatButton(
                        child: Text(
                          'Visit us',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
            ),
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.android),
                      FlatButton(
                        child: Text(
                          'Developers',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
            ),
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.share),
                      FlatButton(
                        child: Text(
                          'Share app',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
            ),
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.close),
                      FlatButton(
                        child: Text(
                          'Log out',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {
                          _signOut(context);
                          Route route = MaterialPageRoute(
                              builder: (context) => LoginPage());
                          Navigator.pushReplacement(context, route);
                        },
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
