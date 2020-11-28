import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextExitButton extends StatelessWidget {
  TextExitButton(
      {Key key, this.text, this.fontWeight, this.onTap, this.isActive})
      : super(key: key);
  final String text;
  final FontWeight fontWeight;
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(text,
            style: TextStyle(
                color:
                    isActive ? Color.fromRGBO(0, 108, 255, 1.0) : Colors.grey,
                fontSize: 18,
                fontWeight: fontWeight)));
  }
}

class DeleteButton extends StatelessWidget {
  DeleteButton({Key key, this.onTap, this.isActive}) : super(key: key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: isActive
            ? Icon(Icons.delete_outlined,
                color: Color.fromRGBO(244, 94, 109, 1.0), size: 25)
            : Icon(Icons.delete_outlined, color: Colors.grey, size: 25));
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
                color: Color.fromRGBO(0, 108, 255, 1.0), size: 25)
            : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 25));
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
              style: TextStyle(fontSize: 14, color: Colors.grey)))
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
          child: Text(DateFormat.jm().format(time),
              style: TextStyle(fontSize: 14, color: Colors.grey)))
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
            color: (isActive ? Colors.green : Colors.grey), size: 50));
  }
}

class DateTimePicker extends StatelessWidget {
  DateTimePicker(
      {Key key, this.mode, this.initialDateTime, this.onChangeDateTime})
      : super(key: key);

  final CupertinoDatePickerMode mode;
  final DateTime initialDateTime;
  final Function onChangeDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 150,
        child: CupertinoDatePicker(
          initialDateTime: initialDateTime,
          mode: mode,
          onDateTimeChanged: onChangeDateTime,
        ));
  }
}
