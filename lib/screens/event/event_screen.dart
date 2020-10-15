import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/screens/event/event_utils.dart';
import 'package:flutterAcmFall/objects/Event.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  List<Event> _events = [];
  bool _openAddEventScreen = false;

  void _openAddEvent() {
    setState(() {
      _openAddEventScreen = true;
    });
  }

  void _closeAddEvent(Event event) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (event != null) {
      _events.add(event);
    }
    setState(() {
      _openAddEventScreen = !_openAddEventScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _openAddEventScreen
        ? AddEventScreen(closeScreen: _closeAddEvent)
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                      children: _events
                          .map((event) => EventCard(event: event))
                          .toList())),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _openAddEvent,
              backgroundColor: Colors.white,
              child: Icon(Icons.add, color: Color.fromRGBO(0, 108, 255, 1.0)),
            ),
          );
  }
}

class EventCard extends StatefulWidget {
  EventCard({Key key, this.event}) : super(key: key);

  final Event event;

  _EventCard createState() => _EventCard();
}

class _EventCard extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        // debug
        child: InkWell(
            onTap: () {
              print(widget.event);
            },
            child: Container(
                height: 80,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(children: <Widget>[
                      RadioButton(
                        onTap: () {
                          setState(() {
                            widget.event.isDone = !widget.event.isDone;
                          });
                        },
                        isActive: widget.event.isDone,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text(widget.event.title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: widget.event.isDone
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: Color.fromRGBO(
                                                37, 42, 49, 1.0)))),
                                widget.event.date != null
                                    ? Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3.0),
                                        child: Row(children: <Widget>[
                                          EventDateFormat(
                                              date: widget.event.date),
                                          widget.event.time != null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: EventTimeFormat(
                                                      time: widget.event.time))
                                              : Container()
                                        ]))
                                    : Container()
                              ]))
                    ])))));
  }
}
