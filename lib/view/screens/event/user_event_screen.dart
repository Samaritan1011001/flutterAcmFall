import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/User.dart';

class UserEventScreen extends StatefulWidget {
  UserEventScreen(
      {Key key, this.events, this.user, this.isOpen, this.closeUserEventScreen})
      : super(key: key);

  final List<Event> events;
  final User user;
  final bool isOpen;
  final Function closeUserEventScreen;

  _UserEventScreen createState() => _UserEventScreen();
}

class _UserEventScreen extends State<UserEventScreen> {
  bool _openAddEventScreen = false;
  bool _openSettingScreen = false;
  Event _cardEvent =
      Event(title: null, date: null, time: null, isDone: false, user: null);

  void _handleOpenAddEventScreen() {
    setState(() {
      _openAddEventScreen = true;
    });
  }

  void _handleCloseAddEventScreen(Event event) {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (event != null) {
      event.user = widget.user;
      widget.events.add(event);
    }

    setState(() {
      _openAddEventScreen = false;
    });
  }

  void _handleCloseSettingScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _openSettingScreen = false;
    });
  }

  void _handleClickEvent(Event event) {
    setState(() {
      _openSettingScreen = true;
      _cardEvent = event;
    });
  }

  void _handleDeleteEvent(Event event) {
    setState(() {
      widget.events.remove(event);
    });
  }

  Widget build(BuildContext context) {
    List<Event> userEvents = [];
    for (int i = 0; i < widget.events.length; i++) {
      if (widget.events[i].user.id == widget.user.id) {
        userEvents.add(widget.events[i]);
      }
    }

    Widget addEventScreen =
        AddEventScreen(closeScreen: _handleCloseAddEventScreen);

    Widget settingEventScreen = EventSettingScreen(
        event: _cardEvent,
        controller: TextEditingController(text: _cardEvent.title),
        isOpen: _openSettingScreen,
        closeSetting: _handleCloseSettingScreen);

    Widget userEventScreen = AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 1000),
        height: MediaQuery.of(context).size.height,
        transform: Matrix4.translationValues(
            0, widget.isOpen ? 0 : MediaQuery.of(context).size.height, 1),
        decoration: BoxDecoration(color: Color.fromRGBO(235, 239, 245, 1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            title: Text("My Events",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            actions: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                  child: TextExitButton(
                      text: "Back",
                      fontWeight: FontWeight.bold,
                      isActive: true,
                      onTap: widget.closeUserEventScreen))
            ],
          ),
          body: EventList(
              events: userEvents,
              modeIsEdit: false,
              handleClickEvent: _handleClickEvent,
              handleDeleteEvent: _handleDeleteEvent),
          floatingActionButton: FloatingActionButton(
            onPressed: _handleOpenAddEventScreen,
            backgroundColor: Color.fromRGBO(0, 108, 255, 1.0),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ));
    return Stack(children: <Widget>[
      userEventScreen,
      settingEventScreen,
      _openAddEventScreen ? addEventScreen : Container(),
    ]);
  }
}
