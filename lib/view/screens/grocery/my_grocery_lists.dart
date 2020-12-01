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
  _MyGroceryListsScreen createState() => _MyGroceryListsScreen();
}

class _MyGroceryListsScreen extends State<MyGroceryListsScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> _listener;

  List<Grocery> myGroceryList = [];
  AppUser _user = AppUser(id: null, group: null, photo: null);

  @override
  void initState() {
    super.initState();
    User currentUser = Provider.of<AuthModel>(context, listen: false).getUser();
    firestoreInstance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((userValue) {
      _user.id = currentUser.uid;
      _user.group = userValue.data()["group"];
      _user.photo = userValue.data()["photoUrl"];
      _listener = firestoreInstance
          .collection("groceries")
          .where("group", isEqualTo: userValue.data()["group"].toString())
          .where("user", isEqualTo: currentUser.uid)
          .snapshots()
          .listen((result) {
        result.docChanges.forEach((res) {
          int idx =
              myGroceryList.indexWhere((grocery) => grocery.id == res.doc.id);
          if (res.doc.data()["isActive"]) {
            Map data = res.doc.data();
            firestoreInstance
                .collection("users")
                .doc(data["user"])
                .get()
                .then((value) {
              List<ChecklistItemModel> checklistitems = data["checklist"]
                  .map<ChecklistItemModel>(
                      (item) => ChecklistItemModel(text: item))
                  .toList();

              Grocery grocery = Grocery(
                  id: res.doc.id,
                  checklist: ChecklistModel(
                      items: checklistitems, date: data["date"].toDate()),
                  isDone: data["isDone"],
                  user: AppUser(
                      id: value.id,
                      group: userValue["group"],
                      photo: value.data()["photoUrl"]));
              if (idx == -1) {
                setState(() {
                  myGroceryList.add(grocery);
                });
              } else {
                setState(() {
                  myGroceryList[idx] = grocery;
                });
              }
            });
          } else {
            if (idx != -1) {
              setState(() {
                myGroceryList.removeAt(idx);
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

  void addToGroceryList(ChecklistModel cm) {
    myGroceryList.add(Grocery(
        checklist: cm, isDone: false, user: AppUser(id: "A1", group: " ")));
    print(myGroceryList.length);
    print(myGroceryList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChecklistCreationScreen(
                    callback: addToGroceryList,
                    checklistModel:
                        ChecklistModel(date: DateTime.now(), items: []),
                    createNew: true)));
          },
        ),
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            title: Text("My Grocery List",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            actions: <Widget>[
              FlatButton(
                  textColor: Color.fromRGBO(0, 108, 255, 1),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: new TextStyle(
                        fontSize: 18,
                        fontFamily: 'SFProText',
                        fontWeight: FontWeight.w700),
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
                            user: _user,
                            checklistModel: myGroceryList[index].checklist,
                            createNew: false)));
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: myGroceryList[index].isDone,
                      onChanged: (bool value) {
                        setState(() {
                          myGroceryList[index].isDone = value;
                          firestoreInstance
                              .collection("groceries")
                              .doc(myGroceryList[index].id)
                              .update({"isDone": myGroceryList[index].isDone});
                        });
                      },
                    ),
                    title: Text(myGroceryList[index].checklist.items[0].text,
                        style:
                            TextStyle(fontFamily: 'SFProText', fontSize: 18)),
                    subtitle: Text(
                        DateFormat('MM/dd/yyyy – kk:mm')
                            .format(myGroceryList[index].checklist.date),
                        style:
                            TextStyle(fontFamily: 'SFProText', fontSize: 14)),
                  ));
            }));
  }
}
