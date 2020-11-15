import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/user_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/model/mock_data.dart';

List<Event> MOCK_DATA = MockData().getDataList();

class EventHomeScreen extends StatefulWidget {
  EventHomeScreen({Key key}) : super(key: key);

  _EventHomeScreen createState() => _EventHomeScreen();
}

class _EventHomeScreen extends State<EventHomeScreen> {
  List<Event> _events = MOCK_DATA;
  User _user = User(id: "1234567", color: Color.fromRGBO(244, 94, 109, 1.0));

  Event _cardEvent =
      Event(title: null, date: null, time: null, isDone: false, user: null);

  bool _openUserEventScreen = false;
  bool _openEditScreen = false;
  bool _openAddEventScreen = false;
  bool _isEditMode = false;

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

  void _handleToggleEdit() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _handleOpenSettingScreen(Event event) {
    setState(() {
      if (event.user.id == _user.id && _isEditMode) {
        _cardEvent = event;
        _openUserEventScreen = false;
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

  void _handleOpenAddEventScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _openAddEventScreen = true;
    });
  }

  void _handleCloseAddEventScreen(Event event) {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (event != null) {
      event.user = _user;
      _events.add(event);
    }

    setState(() {
      _openAddEventScreen = false;
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

    Widget addEventScreen =
        AddEventScreen(closeScreen: _handleCloseAddEventScreen);

    Widget settingEventScreen = EventSettingScreen(
        event: _cardEvent,
        controller: TextEditingController(text: _cardEvent.title),
        isOpen: _openEditScreen,
        closeSetting: _handleCloseSettingScreen);

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
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: _handleOpenAddEventScreen,
              backgroundColor: Color.fromRGBO(0, 108, 255, 1.0),
              child: Icon(Icons.add, color: Colors.white),
            )
          : Container(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: EventList(
                  events: _events,
                  user: _user,
                  modeIsEdit: _isEditMode,
                  handleClickEvent: _handleOpenSettingScreen,
                  handleDeleteEvent: _handleDeleteEvent,
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: InkWell(
                    onTap: _isEditMode ? () {} : _handleOpenUserEventScreen,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: _user.color,
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
      settingEventScreen,
      _openAddEventScreen ? addEventScreen : Container()
    ]);
  }
}
