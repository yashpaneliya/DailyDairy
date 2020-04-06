import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_daily_app/Screens/Settings.dart';
import 'package:temp_daily_app/Screens/home.dart';
import 'package:temp_daily_app/Screens/homepage.dart';
import 'package:temp_daily_app/main.dart';
import 'auth.dart';
import 'auth_provider.dart';

class rootpage extends StatefulWidget {
  @override
  rootpagestate createState() => rootpagestate();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class rootpagestate extends State<rootpage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(
          onSignedOut: _signedOut,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
