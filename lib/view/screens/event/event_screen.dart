import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';

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
    Widget addEventScreen = AddEventScreen(closeScreen: _closeAddEvent);
    Widget mainEventScreen = Scaffold(
      backgroundColor: Color.fromRGBO(235, 239, 245, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                children:
                    _events.map((event) => EventCard(event: event)).toList())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEvent,
        backgroundColor: Color.fromRGBO(0, 108, 255, 1.0),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

    return _openAddEventScreen ? addEventScreen : mainEventScreen;
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
    String title = (widget.event.title.length >= 25)
        ? '${widget.event.title.substring(0, 25)}...'
        : widget.event.title;

    FontWeight titleWeight =
        widget.event.isDone ? FontWeight.bold : FontWeight.normal;

    Widget dateText = widget.event.date != null
        ? Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: EventDateFormat(date: widget.event.date))
        : Container();

    Widget timeText = widget.event.time != null
        ? Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 10.0),
            child: EventTimeFormat(time: widget.event.time))
        : Container();

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
                                    child: Text(title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: titleWeight,
                                            color: Color.fromRGBO(
                                                37, 42, 49, 1.0)))),
                                Row(children: <Widget>[dateText, timeText]),
                              ]))
                    ])))));
  }
}
