import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/widget/event_card.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';

class EventList extends StatefulWidget {
  EventList(
      {Key key, this.events, this.handleClickEvent, this.handleDeleteEvent})
      : super(key: key);

  final List<Event> events;
  final Function handleClickEvent;
  final Function handleDeleteEvent;

  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: widget.events
              .map((event) => EventCard(
                  event: event,
                  onClickEvent: widget.handleClickEvent,
                  onDeleteEvent: widget.handleDeleteEvent))
              .toList()),
    );
  }
}
