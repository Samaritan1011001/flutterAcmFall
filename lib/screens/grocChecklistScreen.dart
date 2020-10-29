
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/checklistCreationScreen.dart';

class ChecklistScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       backgroundColor: Color.fromRGBO(255,255,255,1),
       foregroundColor: Color.fromRGBO(0,108,255,1),
       onPressed: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChecklistCreationScreen()));
       },
     ),
   );
  }}




