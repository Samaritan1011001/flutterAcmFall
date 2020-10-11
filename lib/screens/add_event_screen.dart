import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({Key key}) : super(key: key);

  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen> {
  Map _event = {};

  bool _openMoreSetting = false;
  bool _isDone = false;
  String _eventTitle;
  String _eventNote;
  bool _setDate = false;
  DateTime _eventDate = DateTime.now();
  bool _setTime = false;
  DateTime _eventTime = DateTime.now();

  void _onChangeEventTitle(String eventTitle) {
    setState(() {
      _eventTitle = eventTitle;
    });
  }

  void _onChangeNote(String note) {
    setState(() {
      _eventNote = note;
    });
  }

  void _toggleDate() {
    setState(() {
      _setDate = !_setDate;
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
    });
  }

  void _onChangeTime(DateTime time) {
    setState(() {
      _eventTime = time;
    });
  }

  void _closeMoreSetting() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _openMoreSetting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                // Cancel button: Return null object
                InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      print("Add Event Canceled");
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 25.0),
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                                fontWeight: FontWeight.normal)))),
                // Done button: Return task obj (or add to task list)
                InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      String dateFormat =
                          '${_eventDate.month}-${_eventDate.day}-${_eventDate.year}';
                      String timeFormat =
                          '${_eventTime.hour}:${_eventTime.minute}';
                      _event = {
                        "eventTitle": _eventTitle,
                        "eventNote": _eventNote,
                        "eventDate": dateFormat,
                        "eventTime": timeFormat,
                        "isDone": _isDone
                      };
                      print("New Event Created $_event");
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 25.0),
                        child: Text("Done",
                            style: TextStyle(
                                color:
                                    (_eventTitle != null && _eventTitle != '')
                                        ? Colors.blue
                                        : Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.bold)))),
              ])),
          // Main body: enter Task name and date
          Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    // Radio Button
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isDone = !_isDone;
                          });
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: _isDone
                                ? Icon(Icons.radio_button_checked,
                                    color: Colors.blue, size: 35)
                                : Icon(Icons.radio_button_unchecked,
                                    color: Colors.grey, size: 35))),
                    // Task text
                    Expanded(
                        child: TextField(
                      onChanged: _onChangeEventTitle,
                      decoration: InputDecoration(
                          hintText: "What do you want to do?",
                          hintStyle:
                              TextStyle(fontSize: 23, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0)),
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    )),
                    // More info button: add date and time
                    InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            _openMoreSetting = true;
                          });
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Padding(
                            padding: EdgeInsets.only(right: 20, left: 5),
                            child: Icon(Icons.info_outline,
                                color: Colors.blue, size: 30)))
                  ])))
        ]),
        _openMoreSetting
            ? AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                color: Color.fromRGBO(100, 100, 100, 80))
            : Container(),
        _openMoreSetting
            ? MoreEventSetting(
                eventTitle: _eventTitle,
                note: _eventNote,
                isOpen: _openMoreSetting,
                eventDate: _eventDate,
                setDate: _setDate,
                eventTime: _eventTime,
                setTime: _setTime,
                onChangeNote: _onChangeNote,
                toggleDate: _toggleDate,
                onChangeDate: _onChangeDate,
                toggleTime: _toggleTime,
                onChangeTime: _onChangeTime,
                closeSetting: _closeMoreSetting,
              )
            : Container(),
      ]),
    )));
  }
}

class MoreEventSetting extends StatefulWidget {
  MoreEventSetting(
      {Key key,
      this.eventTitle,
      this.note,
      this.isOpen,
      this.eventDate,
      this.setDate,
      this.eventTime,
      this.setTime,
      @required this.onChangeNote,
      @required this.toggleDate,
      @required this.onChangeDate,
      @required this.toggleTime,
      @required this.onChangeTime,
      @required this.closeSetting})
      : super(key: key);

  final String eventTitle;
  final String note;
  final bool isOpen;
  final bool setDate;
  final DateTime eventDate;
  final bool setTime;
  final DateTime eventTime;
  final Function onChangeNote;
  final Function toggleDate;
  final Function onChangeDate;
  final Function toggleTime;
  final Function onChangeTime;
  final Function closeSetting;

  _MoreEventSetting createState() => _MoreEventSetting();
}

class _MoreEventSetting extends State<MoreEventSetting> {
  @override
  Widget build(BuildContext context) {
    double _settingYOffSet = widget.isOpen ? 30 : 0;
    String _eventTitle = (widget.eventTitle != null && widget.eventTitle != '')
        ? ((widget.eventTitle.length >= 14)
            ? '${widget.eventTitle.substring(0, 15)}...'
            : widget.eventTitle)
        : 'New Event';

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _settingYOffSet, 1),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: Column(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20.0),
                                child: Text(_eventTitle,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)))),
                        InkWell(
                            onTap: widget.closeSetting,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20.0),
                                child: Text("Done",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)))),
                      ])),
              Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          initialValue: widget.note,
                          onChanged: widget.onChangeNote,
                          decoration: InputDecoration(
                              hintText: "Notes",
                              hintStyle:
                                  TextStyle(fontSize: 21, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10.0)),
                          style: TextStyle(fontSize: 21, color: Colors.black),
                        ))),
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
                                    style: TextStyle(fontSize: 21)),
                                InkWell(
                                    onTap: widget.toggleDate,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Icon(
                                        (widget.setDate
                                            ? Icons.toggle_on
                                            : Icons.toggle_off),
                                        color: (widget.setDate
                                            ? Colors.green
                                            : Colors.grey),
                                        size: 65)),
                              ])),
                    )),
                widget.setDate
                    ? Container(
                        color: Colors.white,
                        height: 130,
                        child: CupertinoDatePicker(
                            initialDateTime: widget.eventDate,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: widget.onChangeDate))
                    : Container(),
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
                                    style: TextStyle(fontSize: 21)),
                                InkWell(
                                    onTap: widget.toggleTime,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Icon(
                                        (widget.setTime
                                            ? Icons.toggle_on
                                            : Icons.toggle_off),
                                        color: (widget.setTime
                                            ? Colors.green
                                            : Colors.grey),
                                        size: 65)),
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
              ]),
            ])));
  }
}
