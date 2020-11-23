import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/view/screens/grocery/checklistCreationScreen.dart';
import 'package:intl/intl.dart';

class ChecklistScreen extends StatefulWidget {
  _ChecklistScreen createState() => _ChecklistScreen();
}

class _ChecklistScreen extends State<ChecklistScreen> {
  List<Grocery> grocery = [
    Grocery(
        title: "Milk",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A1", color: Colors.green)),
    Grocery(
        title: "Bread",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A2", color: Colors.red)),
    Grocery(
        title: "Eggs",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A3", color: Colors.blue)),
    Grocery(
        title: "Chocolate",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A4", color: Colors.green)),
    Grocery(
        title: "Ice cream",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A5", color: Colors.red)),
    Grocery(
        title: "Chips",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A6", color: Colors.blue)),
    Grocery(
        title: "Drinks",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A1", color: Colors.green)),
    Grocery(
        title: "Water",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A2", color: Colors.red)),
    Grocery(
        title: "Onions",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A3", color: Colors.blue)),
  ];

  List<Grocery> myGrocery = [
    Grocery(
        title: "My Milk",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A1", color: Colors.green)),
    Grocery(
        title: "My Bread",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A2", color: Colors.red)),
    Grocery(
        title: "My Eggs",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A3", color: Colors.blue)),
    Grocery(
        title: "My Chocolate",
        date: DateTime.now(),
        isDone: false,
        user: User(id: "A3", color: Colors.yellow)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          foregroundColor: Color.fromRGBO(0, 108, 255, 1),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChecklistCreationScreen()));
          },
        ),
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height - 130 - 112 - 70,
                  child: ListView.builder(
                      itemCount: grocery.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(grocery[index].title,
                              style: TextStyle(
                                  fontFamily: 'SFProText', fontSize: 18)),
                          subtitle: Text(
                              DateFormat('MM/dd/yyyy – kk:mm')
                                  .format(grocery[index].date),
                              style: TextStyle(
                                  fontFamily: 'SFProText', fontSize: 14)),
                          value: grocery[index].isDone,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool value) {
                            setState(() {
                              grocery[index].isDone = value;
                            });
                          },
                        );
                      })),
              Container(
                child: Text("My List",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 16)),
                alignment: Alignment(-0.66, 0.0),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                    itemCount: myGrocery.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin:
                              const EdgeInsets.only(left: 58.0, right: 16.0),
                          height: 100,
                          width: 200,
                          constraints:
                              BoxConstraints(minWidth: 301.0, minHeight: 69.0),
                          decoration: new BoxDecoration(
                              color: myGrocery[index].user.color,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                              title: Text(myGrocery[index].title,
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: 'SFProText'))));
                    }),
              )
            ]));
  }
}

class Grocery {
  String title;
  DateTime date;
  bool isDone;
  User user;

  Grocery({this.title, this.date, this.isDone, this.user});

  String toString() {
    return '{title: ${this.title}, date: ${this.date}, isDone: ${this.isDone}, user: $user}';
  }
}
