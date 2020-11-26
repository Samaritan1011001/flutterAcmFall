import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';

class MyGroceryListsScreen extends StatefulWidget{

  _MyGroceryListsScreen createState() => _MyGroceryListsScreen();


}

class _MyGroceryListsScreen extends State<MyGroceryListsScreen>{
  @override
  Widget build(BuildContext context) {

List<ChecklistModel>myGroceryList=[];

void addToGroceryList(ChecklistModel cm){
  myGroceryList.add(cm);
  print(myGroceryList.length);
  setState(() {

  });


}

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),

          onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChecklistCreationScreen(callback: addToGroceryList)));
      },
        ),

      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text("My Grocery List", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30)),

        actions: <Widget>[


        FlatButton(
          textColor: Color.fromRGBO(0, 108, 255, 1),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back", style: new TextStyle(fontSize: 18, fontFamily:'SFProText',fontWeight: FontWeight.w700),

          ))]));
   }

}