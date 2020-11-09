import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';
import 'package:flutterAcmFall/view/widget/event_list.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  List<Event> _events = [];
  bool _openAddEventScreen = false;
  bool _openSettingScreen = false;
  Event _cardEvent =
      Event(id: null, title: null, date: null, time: null, isDone: false);

  void _openAddEvent() {
    setState(() {
      _openAddEventScreen = true;
    });
  }

  void _closeAddEvent(Event event) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (event != null) {
      event.id = _events.length;
      _events.add(event);
    }
    setState(() {
      _openAddEventScreen = !_openAddEventScreen;
    });
  }

  void _closeSettingScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _openSettingScreen = false;
    });
  }

  void _handleClickCard(Event event) {
    setState(() {
      _openSettingScreen = true;
      _cardEvent = event;
    });
  }

  void _handleDeleteCard(Event event) {
    List<Event> events = _events;
    events.remove(event);
    setState(() {
      _events = events;
      for (var i = 0; i < _events.length; i++) {
        _events[i].id = i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget addEventScreen = AddEventScreen(closeScreen: _closeAddEvent);
    Widget settingEventScreen = EventSettingScreen(
        event: _cardEvent,
        controller: TextEditingController(text: _cardEvent.title),
        isOpen: _openSettingScreen,
        closeSetting: _closeSettingScreen);
    Widget mainEventScreen = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title:
            Text("Today", style: TextStyle(fontSize: 35, color: Colors.black)),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 38, horizontal: 16.0),
              child: TextExitButton(
                  text: "Edit",
                  fontWeight: FontWeight.normal,
                  onTap: () {},
                  isActive: true)),
        ],
      ),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Container(
                child: EventList(
              events: _events,
              handleClickEvent: _handleClickCard,
              handleDeleteEvent: _handleDeleteCard,
            )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 94, 109, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 23),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("My Events",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              _events.length > 0
                                  ? Text("${_events.length} events",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(
                                              244, 244, 244, 0.5)))
                                  : Container()
                            ]))))
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEvent,
        backgroundColor: Color.fromRGBO(0, 108, 255, 1.0),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

    return Stack(children: <Widget>[
      mainEventScreen,
      _openAddEventScreen ? addEventScreen : Container(),
      settingEventScreen
    ]);
  }
}
