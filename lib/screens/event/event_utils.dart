import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoneButton extends StatelessWidget {
  DoneButton({Key key, this.onTap, this.isActive}) : super(key: key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text("Done",
            style: TextStyle(
                color:
                    isActive ? Color.fromRGBO(0, 108, 255, 1.0) : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold)));
  }
}

class CancelButton extends StatelessWidget {
  CancelButton({Key key, this.onTap, this.isActive}) : super(key: key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text("Cancel",
            style: TextStyle(
              color: isActive ? Color.fromRGBO(0, 108, 255, 1.0) : Colors.grey,
              fontSize: 18,
            )));
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
                color: Color.fromRGBO(0, 108, 255, 1.0), size: 30)
            : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 30));
  }
}

class EventDateFormat extends StatelessWidget {
  EventDateFormat({Key key, this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
      Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(DateFormat.MMMd('en_US').format(date),
              style: TextStyle(
                  fontSize: 14,
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
      Icon(Icons.access_time_outlined, size: 14, color: Colors.grey),
      Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(DateFormat('h:mm a').format(time),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)))
    ]);
  }
}

class ToggleButton extends StatelessWidget {
  ToggleButton({Key key, this.onTap, this.isActive}) : super(key: key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Icon((isActive ? Icons.toggle_on : Icons.toggle_off),
            color: (isActive ? Colors.green : Colors.grey), size: 55));
  }
}
