import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';

class UserEventScreen extends StatefulWidget {
  UserEventScreen(
      {Key key, this.events, this.user, this.isOpen, this.closeUserEventScreen})
      : super(key: key);

  final List<Event> events;
  final AppUser user;
  final bool isOpen;
  final Function closeUserEventScreen;

  _UserEventScreen createState() => _UserEventScreen();
}

class _UserEventScreen extends State<UserEventScreen> {
  bool _openAddEventScreen = false;
  bool _openSettingScreen = false;
  Event _cardEvent = Event(
      id: null, title: null, date: null, time: null, isDone: false, user: null);

  void _handleOpenAddEventScreen() {
    setState(() {
      _openAddEventScreen = true;
    });
  }

  void _handleCloseAddEventScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());

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

  Widget build(BuildContext context) {
    Widget addEventScreen = AddEventScreen(
        user: widget.user, closeScreen: _handleCloseAddEventScreen);

    Widget settingEventScreen = EventSettingScreen(
        event: _cardEvent,
        controller: TextEditingController(text: _cardEvent.title),
        isEditExistedEvent: true,
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
            events: widget.events,
            user: widget.user,
            modeIsEdit: true,
            handleClickEvent: _handleClickEvent,
          ),
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
