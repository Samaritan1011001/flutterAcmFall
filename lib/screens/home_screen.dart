import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/grocChecklistScreen.dart';

class HomeScreen extends StatelessWidget {
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
            ChecklistScreen(),
            Icon(Icons.directions_transit),
          ],
        ),

      ),
    );
  }
}


