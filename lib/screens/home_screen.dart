import 'package:flutter/material.dart';

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
            Icon(Icons.shopping_basket),
            Icon(Icons.directions_transit),
          ],
        ),

      ),
    );
  }
}

class Nav extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        foregroundColor: Color.fromRGBO(0,108,255,1),
        backgroundColor: Colors.white

      ),
    );

  }

}
