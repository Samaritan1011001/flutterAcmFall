import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/my_grocery_lists.dart';
import 'package:flutterAcmFall/view/widget/logout_button.dart';
import 'package:intl/intl.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ChecklistScreen extends StatefulWidget {
  _ChecklistScreen createState() => _ChecklistScreen();
}

class _ChecklistScreen extends State<ChecklistScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> _listener;

  List<Grocery> _groceries = [];
  AppUser _user = AppUser(id: null, group: null, photo: null);

  int myGrocerListCount = 0;
  /*List<Grocery> grocery = [

    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Milk")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A1", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Bread")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A2", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Eggs")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A3", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Chocolate")],
            date: DateTime.now()),
        isDone: false,
        user: User(id: "A4", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Ice cream")],
            date: DateTime.now()),
        isDone: false,
        user: User(id: "A5", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Chips")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A6", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Drinks")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A1", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Water")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A2", group: " ")),
    Grocery(
        checklist: ChecklistModel(
            items: [ChecklistItemModel(text: "Onions")], date: DateTime.now()),
        isDone: false,
        user: User(id: "A3", group: " ")),
  ];

        user: AppUser(id: "A1", group: " ")),
  ];*/

  @override
  void initState() {
    super.initState();
    User currentUser = Provider.of<AuthModel>(context, listen: false).getUser();
    firestoreInstance.collection("users").doc(currentUser.uid).get().then((userValue) {
      _user.id = currentUser.uid;
      _user.group = userValue.data()["group"];
      _user.photo = userValue.data()["photoUrl"];
      _listener = firestoreInstance.collection("groceries").where("group", isEqualTo: userValue.data()["group"].toString()).snapshots().listen((result) {
        result.docChanges.forEach((res) {
          int idx = _groceries.indexWhere((grocery) => grocery.id == res.doc.id);
          if (res.doc.data()["isActive"]) {
            Map data = res.doc.data();
            firestoreInstance.collection("users").doc(data["user"]).get().then((value) {
              List<ChecklistItemModel> checklistitems =
                  data["checklist"].map<ChecklistItemModel>((item) => ChecklistItemModel(text: item["text"], isChecked: item['isChecked'])).toList();

              print("res.doc.id : ${res.doc.id}");
              Grocery grocery = Grocery(
                  id: res.doc.id,
                  checklist: ChecklistModel(items: checklistitems, date: data["date"].toDate()),
                  isDone: data["isDone"],
                  user: AppUser(id: value.id, group: userValue["group"], photo: value.data()["photoUrl"]));
              if (idx == -1) {
                setState(() {
                  _groceries.add(grocery);
                });
              } else {
                setState(() {
                  _groceries[idx] = grocery;
                });
              }
            });
          } else {
            if (idx != -1) {
              setState(() {
                _groceries.removeAt(idx);
              });
            }
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Grocery> sharedGroceries = [];
    List<Grocery> userGroceries = [];
    for (int i = 0; i < _groceries.length; i++) {
      if (_groceries[i].user.id == _user.id) {
        userGroceries.add(_groceries[i]);
      }

//      if (!_groceries[i].isPrivate) {
      sharedGroceries.add(_groceries[i]);
//      }
    }
    print("userGroceries : ${userGroceries.length}");
    print("_groceries : ${_groceries}");
    print("_user.id : ${_user.id}");

    myGrocerListCount = userGroceries.length;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: LogoutButton(),
            title: Text("Group Grocery List", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              ),
            ]),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 130 - 112 - 70 - 15,
              child: ListView.builder(
                  itemCount: sharedGroceries.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(sharedGroceries[index].checklist.items[0].text, style: TextStyle(fontFamily: 'SFProText', fontSize: 18)),
                      subtitle: Text(DateFormat('MM/dd/yyyy – kk:mm').format(sharedGroceries[index].checklist.date),
                          style: TextStyle(fontFamily: 'SFProText', fontSize: 14)),
                      value: sharedGroceries[index].isDone,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value) {
                        setState(() {
                          sharedGroceries[index].isDone = value;
                        });
                      },
                    );
                  })),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyGroceryListsScreen(
                            userGroceries: userGroceries,
                            user: _user,
                          )));
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                        Text("My Grocery List", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                        myGrocerListCount > 0
                            ? Text("$myGrocerListCount " + (myGrocerListCount == 1 ? "grocery list" : "grocery lists"),
                                style: TextStyle(fontSize: 18, color: Color.fromRGBO(244, 244, 244, 0.5)))
                            : Container()
                      ])),
                ),
              ))
        ]));
  }
}

class Grocery {
  String id;
  ChecklistModel checklist;
  bool isDone;
  AppUser user;

  Grocery({this.id, this.checklist, this.isDone, this.user});

  String toString() {
    return '{checklist: ${this.checklist}, isDone: ${this.isDone}, user: $user, id: $id}';
  }
}
