
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/my_grocery_lists.dart';
import 'package:flutterAcmFall/view/widget/logout_button.dart';
import 'package:intl/intl.dart';

class ChecklistScreen extends StatefulWidget{
  _ChecklistScreen createState() => _ChecklistScreen();
}

class _ChecklistScreen extends State<ChecklistScreen>{
  User _user = User(id: "1234567", group: " ");

  Grocery _cardGrocery =
  Grocery(checklist: null, isDone: false, user: null);




  List<Grocery> grocery = [
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Milk")], date: DateTime.now()), isDone: false, user: User(id:"A1", group:" ") ),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Bread")], date: DateTime.now()), isDone: false, user: User(id:"A2", group:" ")),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Eggs")], date: DateTime.now()),  isDone: false, user: User(id:"A3", group:" ")),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Chocolate")], date: DateTime.now()),  isDone: false, user: User(id:"A4", group:" ") ),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Ice cream")], date: DateTime.now()), isDone: false, user: User(id:"A5", group:" ")),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Chips")], date: DateTime.now()), isDone: false, user: User(id:"A6", group:" ")),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Drinks")], date: DateTime.now()), isDone: false, user: User(id:"A1", group:" ") ),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Water")], date: DateTime.now()), isDone: false, user: User(id:"A2", group:" ")),
    Grocery(checklist:ChecklistModel(items:[ChecklistItemModel(text:"Onions")], date: DateTime.now()), isDone: false, user: User(id:"A3", group:" ")),
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
         leading: LogoutButton(),
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
               title: Text(grocery[index].checklist.items[0].text, style: TextStyle(fontFamily: 'SFProText', fontSize: 18)),
               subtitle: Text(DateFormat('MM/dd/yyyy – kk:mm').format(grocery[index].checklist.date), style: TextStyle(fontFamily: 'SFProText', fontSize: 14)),
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
    ChecklistModel checklist;
    bool isDone;
    AppUser user;

    Grocery({this.checklist, this.isDone, this.user});

    String toString() {
      return '{checklist: ${this.checklist}, isDone: ${this.isDone}, user: $user}';
    }
  }




