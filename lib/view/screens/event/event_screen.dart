import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/event/add_event_screen.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';
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

  void _handleChosenCard(Event event) {
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
        isOpen: _openSettingScreen,
        isEdit: true,
        closeSetting: _closeSettingScreen);
    Widget mainEventScreen = Scaffold(
      backgroundColor: Color.fromRGBO(235, 239, 245, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                children: _events
                    .map((event) => EventCard(
                          event: event,
                          onClickCard: _handleChosenCard,
                          onDeleteCard: _handleDeleteCard,
                        ))
                    .toList())),
      ),
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

class EventCard extends StatefulWidget {
  EventCard({Key key, this.event, this.onClickCard, this.onDeleteCard})
      : super(key: key);

  final Event event;
  final Function onClickCard;
  final Function onDeleteCard;

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
              widget.onClickCard(widget.event);
            },
            child: Container(
                height: 80,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: <Widget>[
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Text(title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: titleWeight,
                                                  color: Color.fromRGBO(
                                                      37, 42, 49, 1.0)))),
                                      Row(children: <Widget>[
                                        dateText,
                                        timeText
                                      ]),
                                    ]))
                          ]),
                          DeleteButton(
                            onTap: () {
                              widget.onDeleteCard(widget.event);
                            },
                            isActive: true,
                          ),
                        ])))));
  }
}
