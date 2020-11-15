import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterAcmFall/view/widget/event_card.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/User.dart';

class EventList extends StatefulWidget {
  EventList(
      {Key key,
      this.events,
      this.user,
      this.modeIsEdit,
      this.handleClickEvent,
      this.handleDeleteEvent})
      : super(key: key);

  final List<Event> events;
  final User user;
  final bool modeIsEdit;
  final Function handleClickEvent;
  final Function handleDeleteEvent;

  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> {
  Widget build(BuildContext context) {
    widget.events.sort((Event a, Event b) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateFormat timeFormat = DateFormat("HH:mm:ss");

      String dateA = dateFormat.format(a.date).toString();
      String timeA = timeFormat.format(a.time).toString();

      DateTime dateTimeA = DateTime.parse(dateA + " " + timeA);

      String dateB = dateFormat.format(b.date).toString();
      String timeB = timeFormat.format(b.time).toString();

      DateTime dateTimeB = DateTime.parse(dateB + " " + timeB);

      return dateTimeA.compareTo(dateTimeB);
    });
    return SingleChildScrollView(
      child: Column(
          children: widget.events
              .map((event) => EventCard(
                  event: event,
                  user: widget.user,
                  modeIsEdit: widget.modeIsEdit,
                  onClickEvent: widget.handleClickEvent,
                  onDeleteEvent: widget.handleDeleteEvent))
              .toList()),
    );
  }
}
