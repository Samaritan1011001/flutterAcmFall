import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/grocChecklistScreen.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'dart:async';

class MyGroceryListsScreen extends StatefulWidget {
  List<Grocery> userGroceries = [];
  AppUser user = AppUser(id: null, group: null, photo: null);
  MyGroceryListsScreen({this.userGroceries, this.user});
  _MyGroceryListsScreen createState() => _MyGroceryListsScreen();
}

class _MyGroceryListsScreen extends State<MyGroceryListsScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  List<Grocery> myGroceryList = [];

  @override
  void initState() {
    super.initState();
    myGroceryList = widget.userGroceries;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addToGroceryList(ChecklistModel cm, bool createNew, String gid) {
    if (createNew) {
      myGroceryList.add(Grocery(checklist: cm, isDone: false, user: widget.user));
//      print(myGroceryList.length);
//      print(myGroceryList);
    } else {
      int ind = myGroceryList.indexWhere((element) => element.id == gid);
      if (ind != -1) {
        myGroceryList[ind].checklist = cm;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("myGroceryList : ${myGroceryList}");

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChecklistCreationScreen(
                    callback: addToGroceryList,
                    checklistModel: ChecklistModel(date: DateTime.now(), items: []),
                    user: widget.user,
                    groceryId: null,
                    createNew: true)));
          },
        ),
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            title: Text("My Grocery List", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
            actions: <Widget>[
              FlatButton(
                  textColor: Color.fromRGBO(0, 108, 255, 1),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: new TextStyle(fontSize: 18, fontFamily: 'SFProText', fontWeight: FontWeight.w700),
                  ))
            ]),
        body: ListView.builder(
            itemCount: myGroceryList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChecklistCreationScreen(
                            callback: addToGroceryList,
                            user: widget.user,
                            checklistModel: myGroceryList[index].checklist,
                            groceryId: myGroceryList[index].id,
                            createNew: false)));
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: myGroceryList[index].isDone,
                      onChanged: (bool value) {
                        setState(() {
                          myGroceryList[index].isDone = value;
                          firestoreInstance.collection("groceries").doc(myGroceryList[index].id).update({"isDone": myGroceryList[index].isDone});
                        });
                      },
                    ),
                    title: Text(myGroceryList[index].checklist.items[0].text, style: TextStyle(fontFamily: 'SFProText', fontSize: 18)),
                    subtitle: Text(DateFormat('MM/dd/yyyy – kk:mm').format(myGroceryList[index].checklist.date),
                        style: TextStyle(fontFamily: 'SFProText', fontSize: 14)),
                  ));
            }));
  }
}
