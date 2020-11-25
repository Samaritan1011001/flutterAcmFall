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
  bool _isEditMode = false;

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
      _listener =
          firestoreInstance.collection("groups").snapshots().listen((result) {
        result.docChanges.forEach((res) {
          if (res.doc.id == _user.group) {
            _events = [];
            for (var id in res.doc.data()["share_events"].keys) {
              firestoreInstance
                  .collection("events")
                  .doc(id)
                  .get()
                  .then((eventValue) {
                Map eventData = eventValue.data();
                AppUser user = AppUser(
                  id: eventData["user"],
                  group: eventData["group"],
                );
                Event event = Event(
                  id: id,
                  title: eventData["title"],
                  date: eventData["date"].toDate(),
                  time: eventData["time"].toDate(),
                  isDone: eventData["isDone"],
                  user: user,
                );
                setState(() {
                  _events.add(event);
                });
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
      _isEditMode = false;
      _openUserEventScreen = true;
    });
  }

  void _handleCloseUserEventScreen() {
    setState(() {
      _openUserEventScreen = false;
    });
  }

  void _handleToggleEdit() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _handleDeleteEvent(Event event) {
    setState(() {
      _events.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    int userEventsCount = 0;
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].user.id == _user.id) {
        userEventsCount += 1;
      }
    }

    Widget userEventScreen = UserEventScreen(
      events: _events,
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
                  fontSize: 30)),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                child: InkWell(
                    onTap: _handleToggleEdit,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(_isEditMode ? "Cancel" : "Edit",
                        style: TextStyle(
                            color: _isEditMode
                                ? Color.fromRGBO(244, 94, 109, 1.0)
                                : Color.fromRGBO(0, 108, 255, 1.0),
                            fontSize: 18,
                            fontWeight: FontWeight.bold))))
          ]),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height - 130 - 112 - 70,
                child: EventList(
                  events: _events,
                  user: _user,
                  modeIsEdit: _isEditMode,
                  handleClickEvent: (Event event) {},
                  handleDeleteEvent: _handleDeleteEvent,
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
                                  userEventsCount > 0
                                      ? Text(
                                          "$userEventsCount " +
                                              (userEventsCount == 1
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
