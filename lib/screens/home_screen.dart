import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser;    // ⇐ NEW
  HomeScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          color: Colors.teal,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.schedule)),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.shopping_basket),
            Icon(Icons.directions_transit),
          ],
        ),

      ),
    );
  }
}
