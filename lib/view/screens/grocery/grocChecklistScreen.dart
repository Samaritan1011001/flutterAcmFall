
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/my_grocery_lists.dart';
import 'package:flutterAcmFall/view/widget/logout_button.dart';
import 'package:intl/intl.dart';

class ChecklistScreen extends StatefulWidget{
  _ChecklistScreen createState() => _ChecklistScreen();
}

class _ChecklistScreen extends State<ChecklistScreen>{
  User _user = User(id: "1234567", color: Color.fromRGBO(244, 94, 109, 1.0));

  Grocery _cardGrocery =
  Grocery(title: null, date: null, isDone: false, user: null);

  bool _openUserGrocScreen = false;
  bool _openEditScreen = false;
  bool _isEditMode = false;

  void _handleOpenUserGrocScreen() {
    setState(() {
      _openUserGrocScreen = true;
    });
  }

  void _handleCloseUserGrocScreen() {
    setState(() {
      _openUserGrocScreen = false;
    });
  }

  void _handleToggleEdit() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _handleOpenSettingScreen(Grocery grocery1) {
    setState(() {
      if (grocery1.user.id == _user.id && _isEditMode) {
        _cardGrocery = grocery1;
        _openUserGrocScreen = false;
        _openEditScreen = true;
      }
    });
  }

  void _handleCloseSettingScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _openEditScreen = false;
    });
  }

  void _handleDeleteEvent(Grocery grocery1) {
    setState(() {
      grocery.remove(grocery1);
    });
  }



  List<Grocery> grocery = [
    Grocery(title:"Milk", date: DateTime.now(), isDone: false, user: User(id:"A1", color:Colors.green) ),
    Grocery(title:"Bread", date: DateTime.now(),isDone: false, user: User(id:"A2", color:Colors.red)),
    Grocery(title:"Eggs", date: DateTime.now(), isDone: false, user: User(id:"A3", color:Colors.blue)),
    Grocery(title:"Chocolate", date: DateTime.now(), isDone: false, user: User(id:"A4", color:Colors.green) ),
    Grocery(title:"Ice cream", date: DateTime.now(),isDone: false, user: User(id:"A5", color:Colors.red)),
    Grocery(title:"Chips", date: DateTime.now(), isDone: false, user: User(id:"A6", color:Colors.blue)),
    Grocery(title:"Drinks", date: DateTime.now(), isDone: false, user: User(id:"A1", color:Colors.green) ),
    Grocery(title:"Water", date: DateTime.now(),isDone: false, user: User(id:"A2", color:Colors.red)),
    Grocery(title:"Onions", date: DateTime.now(), isDone: false, user: User(id:"A3", color:Colors.blue)),
  ];



  @override
  Widget build(BuildContext context) {
    /*int userGrocCount = 0;
    for(int i=0; i<ChecklistModel().items.length; i++){
      if(ChecklistModel().items[i].User.id == _user.id){
        userGrocCount +=1;
      }

    }*/
   return Scaffold(
     backgroundColor: Colors.white,


     appBar: AppBar(
         toolbarHeight: 80,
         backgroundColor: Colors.white,
         shadowColor: Colors.transparent,
         title: Text("Group Grocery List",
             style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: 30)),
         actions: <Widget>[
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
           ),

         ]),

     body:
     Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget> [
         Container(
             height: MediaQuery.of(context).size.height - 130 - 112 - 70,


          child: ListView.builder(

              itemCount: grocery.length,
           itemBuilder: (context, index) {
             return CheckboxListTile(
               title: Text(grocery[index].title, style: TextStyle(fontFamily: 'SFProText', fontSize: 18)),
               subtitle: Text(DateFormat('MM/dd/yyyy – kk:mm').format(grocery[index].date), style: TextStyle(fontFamily: 'SFProText', fontSize: 14)),
               value: grocery[index].isDone,
               controlAffinity: ListTileControlAffinity.leading,


               onChanged: (bool value) {
                 setState(() {
                   grocery[index].isDone = value;
                 });
               },
             );
           })),

      Padding(
         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: InkWell(
          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyGroceryListsScreen()));},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
           child:  Container(
                      height:100,
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                           Text("My Grocery List", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)),
                            /*userGrocCount > 0
                                ? Text(
                                "$userGrocCount " +
                                    (userGrocCount == 1
                                        ? "grocery list"
                                        : "grocery lists"),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(
                                        244, 244, 244, 0.5)))
                                : Container()*/


                   ])),
                ),
                   ))]
     ));
  }

  }

  class Grocery{
    String title;
    DateTime date;
    bool isDone;
    User user;

    Grocery({this.title, this.date, this.isDone, this.user});

    String toString() {
      return '{title: ${this.title}, date: ${this.date}, isDone: ${this.isDone}, user: $user}';
    }
  }




