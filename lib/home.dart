import 'package:reo4/novoProd.dart';
import 'package:reo4/services/firebase_services.dart';
import 'package:reo4/homeTab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reo4/pagCarrin.dart';

class TelaHome extends StatefulWidget {
  @override
  _TelaHome createState() => _TelaHome();
}

class _TelaHome extends State<TelaHome> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              //controller: _tabsPageController,
              //onPageChanged: (num) {
              // setState(() {
              //_selectedTab = num;
              // });
              //   },
              children: [
                HomeTab(),
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Carrin()),
                );
              }),
        ],
      ),
    );
  }
}
