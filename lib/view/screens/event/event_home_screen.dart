import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterAcmFall/view/screens/event/user_event_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/view/widget/logout_button.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventHomeScreen extends StatefulWidget {
  EventHomeScreen({Key key}) : super(key: key);

  _EventHomeScreen createState() => _EventHomeScreen();
}

class _EventHomeScreen extends State<EventHomeScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> _listener;

  List<Event> _events = [];
  AppUser _user = AppUser(id: null, group: null);

  bool _openUserEventScreen = false;

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
          .collection("events")
          .where("group", isEqualTo: userValue.data()["group"])
          .snapshots()
          .listen((result) {
        result.docChanges.forEach((res) {
          int idx = _events.indexWhere((event) => event.id == res.doc.id);
          if (res.doc.data()["isActive"]) {
            Map data = res.doc.data();
            firestoreInstance
                .collection("users")
                .doc(data["user"])
                .get()
                .then((value) {
              Event event = Event(
                  id: res.doc.id,
                  title: data["title"],
                  date: data["date"].toDate(),
                  time: data["time"].toDate(),
                  isDone: data["isDone"],
                  isPrivate: data["isPrivate"],
                  user: AppUser(
                      id: value.id,
                      group: userValue["group"],
                      photo: value.data()["photoUrl"]));
              if (idx == -1) {
                setState(() {
                  _events.add(event);
                });
              } else {
                setState(() {
                  _events[idx] = event;
                });
              }
            });
          } else {
            if (idx != -1) {
              setState(() {
                _events.removeAt(idx);
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

  void _handleOpenUserEventScreen() {
    setState(() {
      _openUserEventScreen = true;
    });
  }

  void _handleCloseUserEventScreen() {
    setState(() {
      _openUserEventScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Event> shareEvents = [];
    List<Event> userEvents = [];
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].user.id == _user.id) {
        userEvents.add(_events[i]);
      }

      if (!_events[i].isPrivate) {
        shareEvents.add(_events[i]);
      }
    }

    Widget userEventScreen = UserEventScreen(
      events: userEvents,
      user: _user,
      isOpen: _openUserEventScreen,
      closeUserEventScreen: _handleCloseUserEventScreen,
    );

    Widget mainEventScreen = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: LogoutButton(),
          title: Text("Group Events",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30))),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height - 130 - 112 - 70,
                child: EventList(
                  events: shareEvents,
                  user: _user,
                  modeIsEdit: false,
                  handleClickEvent: (Event event) {},
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: InkWell(
                    onTap: _handleOpenUserEventScreen,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 94, 109, 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text("My Events",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  userEvents.length > 0
                                      ? Text(
                                          "${userEvents.length} " +
                                              (userEvents.length == 1
                                                  ? "event"
                                                  : "events"),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  244, 244, 244, 0.5)))
                                      : Container()
                                ])))))
          ]),
    );

    return Stack(children: <Widget>[
      mainEventScreen,
      userEventScreen,
    ]);
  }
}
