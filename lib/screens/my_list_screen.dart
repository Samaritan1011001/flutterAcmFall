import 'package:flutter/material.dart';

class MyListScreen extends StatefulWidget{
  _MyListScreen createState() => _MyListScreen();
}

class _MyListScreen extends State<MyListScreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
         toolbarHeight: 80,
         backgroundColor: Colors.white,
         shadowColor: Colors.transparent,
         title: Text("My List",
             style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: 30)),
         actions: <Widget>[
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
           ),

         ]),






   );
  }
