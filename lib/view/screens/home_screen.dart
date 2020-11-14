import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'package:flutterAcmFall/view/screens/event/event_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Provider.of<AuthModel>(context, listen: false)
                .signOutGoogle();
          },
          tooltip: 'Logout',
          child: const Icon(Icons.logout),
        ),
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
            //Icon(Icons.directions_transit),
            EventScreen(),
          ],
        ),
      ),
    );
  }
}
