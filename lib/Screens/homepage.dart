import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_daily_app/Screens/profile.dart';
import 'Settings.dart';
import 'SubscribedPage.dart';
import 'cart.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;

  const HomePage({Key key, this.onSignedOut});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool select = true;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    ProfilePage(),
    SubscribedPlan(),
    Settings(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        title: Text(
          'Daily Dairy',
          style: TextStyle(
              color: Color.fromRGBO(22, 102, 225, 1),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text('Tap Back to exit')),
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        },
        backgroundColor: Color.fromRGBO(22, 102, 225, 1),
        child: Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home(); // if user taps on this homepage tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Color.fromRGBO(22, 102, 225, 1)
                              : Colors.grey,
                        ),
                        Visibility(
                            visible: currentTab == 0 ? true : false,
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color: currentTab == 0
                                    ? Color.fromRGBO(22, 102, 225, 1)
                                    : Colors.grey,
                              ),
                            ))
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ProfilePage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          color: currentTab == 1
                              ? Color.fromRGBO(22, 102, 225, 1)
                              : Colors.grey,
                        ),
                        Visibility(
                          visible: currentTab == 1 ? true : false,
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Color.fromRGBO(22, 102, 225, 1)
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            SubscribedPlan(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.playlist_add_check,
                          color: currentTab == 2
                              ? Color.fromRGBO(22, 102, 225, 1)
                              : Colors.grey,
                        ),
                        Visibility(
                          visible: currentTab == 2 ? true : false,
                          child: Text(
                            'Subscribed\n      Plan',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Color.fromRGBO(22, 102, 225, 1)
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Settings(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: currentTab == 3
                              ? Color.fromRGBO(22, 102, 225, 1)
                              : Colors.grey,
                        ),
                        Visibility(
                          visible: currentTab == 3 ? true : false,
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Color.fromRGBO(22, 102, 225, 1)
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
