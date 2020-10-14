import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutterAcmFall/objects/Event.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({
    Key key,
    this.isOpen,
    this.closeAddEvent,
  }) : super(key: key);

  final bool isOpen;
  final Function closeAddEvent;

  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen> {
  bool _openMoreSetting = false;

  bool _isDone = false;

  String _eventTitle;

  bool _setDate = false;
  DateTime _eventDate = DateTime.now();

  bool _setTime = false;
  DateTime _eventTime = DateTime.now();

  void _onChangeEventTitle(String eventTitle) {
    setState(() {
      _eventTitle = eventTitle;
    });
  }

  void _toggleDate() {
    setState(() {
      _setDate = !_setDate;
      if (!_setDate) {
        _setTime = false;
        _eventDate = DateTime.now();
        _eventTime = DateTime.now();
      }
    });
  }

  void _onChangeDate(DateTime date) {
    setState(() {
      _eventDate = date;
    });
  }

  void _toggleTime() {
    setState(() {
      _setTime = !_setTime;
      if (!_setTime) {
        _eventTime = DateTime.now();
      }
    });
  }

  void _onChangeTime(DateTime time) {
    setState(() {
      _eventTime = time;
    });
  }

  void _toggleMoreSetting() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _openMoreSetting = !_openMoreSetting;
    });
  }

  @override
  Widget build(BuildContext context) {
    Event _event = Event(
        title: _eventTitle,
        date: _setDate ? _eventDate : null,
        time: _setTime ? _eventTime : null,
        isDone: _isDone);

    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(children: <Widget>[
        Column(children: <Widget>[
          // Header bar: Cancel and Done button
          Container(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Cancel button: Return null object
                        CancelButton(
                            onTap: () {
                              _event = null;
                              widget.closeAddEvent(_event);
                            },
                            isActive: true),
                        // Done button: Return task obj (or add to task list)
                        DoneButton(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              if (_eventTitle != null) {
                                widget.closeAddEvent(_event);
                              }
                            },
                            isActive:
                                (_eventTitle != null && _eventTitle != '')),
                      ]))),
          // Main body: enter Task name and date
          Container(
              child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Row(children: <Widget>[
                    // Radio Button
                    RadioButton(
                        onTap: () {
                          setState(() {
                            _isDone = !_isDone;
                          });
                        },
                        isActive: _isDone),
                    // Task text
                    Expanded(
                        child: TextField(
                      onChanged: _onChangeEventTitle,
                      decoration: InputDecoration(
                          hintText: "What do you want to do?",
                          hintStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0)),
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight:
                              _isDone ? FontWeight.bold : FontWeight.normal,
                          color: Color.fromRGBO(37, 42, 49, 1.0)),
                    )),
                    // More info button: add date and time
                    InkWell(
                        onTap: _toggleMoreSetting,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Icon(Icons.info_outline,
                            color: Color.fromRGBO(0, 108, 255, 1.0), size: 30))
                  ]))),
          _setDate
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: Row(children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 20, color: Colors.grey)),
                      Text(DateFormat.MMMd('en_US').format(_eventDate),
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey))
                    ]),
                    _setTime
                        ? Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 5),
                                child: Icon(Icons.access_time_outlined,
                                    size: 20, color: Colors.grey)),
                            Text(DateFormat('h:mm a').format(_eventTime),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                          ])
                        : Container(),
                  ]))
              : Container(),
        ]),
        _openMoreSetting
            ? AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                color: Color.fromRGBO(180, 180, 180, 80))
            : Container(),
        MoreEventSetting(
          eventTitle: _eventTitle,
          isOpen: _openMoreSetting,
          eventDate: _eventDate,
          setDate: _setDate,
          eventTime: _eventTime,
          setTime: _setTime,
          onChangeEventTitle: _onChangeEventTitle,
          toggleDate: _toggleDate,
          onChangeDate: _onChangeDate,
          toggleTime: _toggleTime,
          onChangeTime: _onChangeTime,
          closeSetting: _toggleMoreSetting,
        ),
      ]),
    )));
  }
}

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
                fontSize: 23,
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
              fontSize: 23,
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
                color: Color.fromRGBO(0, 108, 255, 1.0), size: 35)
            : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 35));
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
            color: (isActive ? Colors.green : Colors.grey), size: 65));
  }
}

class MoreEventSetting extends StatefulWidget {
  MoreEventSetting(
      {Key key,
      this.eventTitle,
      this.isOpen,
      this.eventDate,
      this.setDate,
      this.eventTime,
      this.setTime,
      this.onChangeEventTitle,
      this.toggleDate,
      this.onChangeDate,
      this.toggleTime,
      this.onChangeTime,
      this.closeSetting})
      : super(key: key);

  final String eventTitle;
  final bool isOpen;
  final bool setDate;
  final DateTime eventDate;
  final bool setTime;
  final DateTime eventTime;
  final Function onChangeEventTitle;
  final Function toggleDate;
  final Function onChangeDate;
  final Function toggleTime;
  final Function onChangeTime;
  final Function closeSetting;

  _MoreEventSetting createState() => _MoreEventSetting();
}

class _MoreEventSetting extends State<MoreEventSetting> {
  double _settingYOffSet;

  @override
  Widget build(BuildContext context) {
    _settingYOffSet = widget.isOpen ? 30 : MediaQuery.of(context).size.height;
    String _eventTitle = (widget.eventTitle != null && widget.eventTitle != '')
        ? ((widget.eventTitle.length >= 15)
            ? '${widget.eventTitle.substring(0, 15)}...'
            : widget.eventTitle)
        : 'New Event';

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(0, _settingYOffSet, 1),
      decoration: BoxDecoration(
          color: Color.fromRGBO(235, 239, 245, 1.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          )),
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              )),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_eventTitle,
                        style: TextStyle(
                            color: Color.fromRGBO(37, 42, 49, 1.0),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    DoneButton(onTap: widget.closeSetting, isActive: true)
                  ])),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Set date reminder",
                            style: TextStyle(
                                color: Color.fromRGBO(37, 42, 49, 1.0),
                                fontSize: 21)),
                        ToggleButton(
                            onTap: widget.toggleDate, isActive: widget.setDate),
                      ])),
            )),
        widget.setDate
            ? Column(children: <Widget>[
                Container(
                    color: Colors.white,
                    height: 130,
                    child: CupertinoDatePicker(
                        initialDateTime: widget.eventDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: widget.onChangeDate)),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Set time reminder",
                                    style: TextStyle(
                                        color: Color.fromRGBO(37, 42, 49, 1.0),
                                        fontSize: 21)),
                                ToggleButton(
                                    onTap: widget.toggleTime,
                                    isActive: widget.setTime),
                              ])),
                    )),
                widget.setTime
                    ? Container(
                        color: Colors.white,
                        height: 130,
                        child: CupertinoDatePicker(
                            initialDateTime: widget.eventTime,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: widget.onChangeTime))
                    : Container(),
              ])
            : Container(),
      ]),
    );
  }
}
