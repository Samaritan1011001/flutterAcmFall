import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/grocChecklistScreen.dart';
import 'package:intl/intl.dart';

typedef void CountCallback(int count);

class MyGroceryListsScreen extends StatefulWidget {
  _MyGroceryListsScreen createState() => _MyGroceryListsScreen();
}

class _MyGroceryListsScreen extends State<MyGroceryListsScreen> {
  List<Grocery> myGroceryList = [];

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
                            checklistModel: myGroceryList[index].checklist,
                            createNew: false)));
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: myGroceryList[index].isDone,
                      onChanged: (bool value) {
                        setState(() {
                          myGroceryList[index].isDone = value;
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
