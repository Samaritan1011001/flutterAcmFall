import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/user_event_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/model/mock_data.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  List<Event> _events = MockData().getDataList();
  //List<Event> _events = [];
  User _user = User(id: "1234567", color: Color.fromRGBO(244, 94, 109, 1.0));
  bool _openUserEventScreen = false;

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

  void _handleDeleteEvent(Event event) {
    setState(() {
      _events.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Event> userEvents = [];
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].user.id == _user.id) {
        userEvents.add(_events[i]);
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
          title: Text("Share Events",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30))),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: EventList(
                  events: _events,
                  modeIsEdit: true,
                  handleClickEvent: (Event event) {
                    print(event);
                  },
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
                                  userEvents.length > 0
                                      ? Text("${userEvents.length} events",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  244, 244, 244, 0.5)))
                                      : Container()
                                ])))))
          ]),
    );

    return Stack(children: <Widget>[mainEventScreen, userEventScreen]);
  }
}
