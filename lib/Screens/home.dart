import 'package:flutter/material.dart';
import 'package:temp_daily_app/Screens/CheesePage.dart';
import 'package:temp_daily_app/Screens/butterPage.dart';
import 'package:temp_daily_app/Screens/paneerProduct.dart';

import 'MilkPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool select = true;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 42, fontFamily: 'Varela'),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Color.fromRGBO(22, 102, 225, 1),
            labelColor: Color.fromRGBO(22, 102, 225, 1),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  'Milk',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Cheese',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Paneer',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Butter',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 520,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                milkProduct(),
                cheeseProduct(),
                paneerProduct(),
                butterProduct()
              ],
            ),
          )
        ],
      ),
    );
  }
}
