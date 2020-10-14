import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/add_event_screen.dart';
import 'package:flutterAcmFall/objects/Event.dart';
import 'package:intl/intl.dart';

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
        ? AddEventScreen(
            isOpen: _openAddEventScreen, closeAddEvent: _closeAddEvent)
        : Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        children: _events
                            .map((event) => EventCard(event: event))
                            .toList()))),
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
        child: Container(
            height: 80,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                            Text(widget.event.title,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: widget.event.isDone
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Color.fromRGBO(37, 42, 49, 1.0))),
                            widget.event.date != null
                                ? Row(children: <Widget>[
                                    EventDateFormat(date: widget.event.date),
                                    widget.event.time != null
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: EventTimeFormat(
                                                time: widget.event.time))
                                        : Container()
                                  ])
                                : Container()
                          ]))
                ]))));
  }
}

class EventDateFormat extends StatelessWidget {
  EventDateFormat({Key key, this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey),
      Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(DateFormat.MMMd('en_US').format(date),
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)))
    ]);
  }
}

class EventTimeFormat extends StatelessWidget {
  EventTimeFormat({Key key, this.time}) : super(key: key);

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(Icons.access_time_outlined, size: 18, color: Colors.grey),
      Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(DateFormat('h:mm a').format(time),
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)))
    ]);
  }
}

class RadioButton extends StatelessWidget {
  RadioButton({Key key, this.onTap, this.isActive}) : super(key: key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: isActive
            ? Icon(Icons.radio_button_checked,
                color: Color.fromRGBO(0, 108, 255, 1.0), size: 35)
            : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 35));
  }
}
