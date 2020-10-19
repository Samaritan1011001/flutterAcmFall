import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/objects/Event.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({
    Key key,
    this.closeScreen,
  }) : super(key: key);

  final Function closeScreen;

  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen> {
  Event _event = Event(
      title: null, date: DateTime.now(), time: DateTime.now(), isDone: false);

  bool _openMoreSetting = false;
  bool _setDate = false;
  bool _setTime = false;

  void _onChangeEventTitle(String eventTitle) {
    setState(() {
      _event.title = eventTitle;
    });
  }

  void _toggleDate() {
    setState(() {
      _setDate = !_setDate;
      if (!_setDate) {
        _setTime = false;
        _event.date = DateTime.now();
        _event.time = DateTime.now();
      }
    });
  }

  void _toggleTime() {
    setState(() {
      _setTime = !_setTime;
      if (!_setTime) {
        _event.time = DateTime.now();
      }
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
    Widget backdrop = _openMoreSetting
        ? AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            color: Color.fromRGBO(180, 180, 180, 80))
        : Container();

    Widget dateText =
        _setDate ? EventDateFormat(date: _event.date) : Container();

    Widget timeText = _setTime
        ? Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: EventTimeFormat(time: _event.time))
        : Container();

    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(children: <Widget>[
        Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Cancel button: Return null object
                    CancelButton(
                        onTap: () {
                          _event = null;
                          widget.closeScreen(_event);
                        },
                        isActive: true),
                    DoneButton(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (_event.title != null) {
                            if (!_setDate) {
                              _event.date = null;
                            }
                            if (!_setTime) {
                              _event.time = null;
                            }
                            widget.closeScreen(_event);
                          }
                        },
                        isActive: (_event.title != null && _event.title != '')),
                  ])),
          Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 20.0),
              child: Row(children: <Widget>[
                // Radio Button
                RadioButton(
                    onTap: () {
                      setState(() {
                        _event.isDone = !_event.isDone;
                      });
                    },
                    isActive: _event.isDone),
                Expanded(
                    child: TextField(
                  onChanged: _onChangeEventTitle,
                  decoration: InputDecoration(
                      hintText: "What do you want to do?",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0)),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          _event.isDone ? FontWeight.bold : FontWeight.normal,
                      color: Color.fromRGBO(37, 42, 49, 1.0)),
                )),
                InkWell(
                    onTap: _toggleMoreSetting,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Icon(Icons.info_outline,
                        color: Color.fromRGBO(0, 108, 255, 1.0), size: 25)),
              ])),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(children: <Widget>[dateText, timeText])),
        ]),
        backdrop,
        MoreEventSetting(
          event: _event,
          isOpen: _openMoreSetting,
          setDate: _setDate,
          setTime: _setTime,
          toggleDate: _toggleDate,
          toggleTime: _toggleTime,
          closeSetting: _toggleMoreSetting,
        ),
      ]),
    )));
  }
}

class MoreEventSetting extends StatefulWidget {
  MoreEventSetting(
      {Key key,
      this.event,
      this.isOpen,
      this.setDate,
      this.setTime,
      this.toggleDate,
      this.toggleTime,
      this.closeSetting})
      : super(key: key);

  final Event event;
  final bool isOpen;
  final bool setDate;
  final bool setTime;
  final Function toggleDate;
  final Function toggleTime;
  final Function closeSetting;

  _MoreEventSetting createState() => _MoreEventSetting();
}

class _MoreEventSetting extends State<MoreEventSetting> {
  @override
  Widget build(BuildContext context) {
    double _settingYOffSet =
        widget.isOpen ? 25 : MediaQuery.of(context).size.height;
    String _eventTitle =
        (widget.event.title != null && widget.event.title != '')
            ? ((widget.event.title.length >= 22)
                ? '${widget.event.title.substring(0, 22)}...'
                : widget.event.title)
            : 'New Event';

    Widget timePicker = widget.setTime
        ? DateTimePicker(
            initialDateTime: widget.event.time,
            mode: CupertinoDatePickerMode.time,
            onChangeDateTime: (DateTime time) {
              setState(() {
                widget.event.time = time;
              });
            })
        : Container();

    Widget toggleTimeBar = widget.setDate
        ? Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Set time reminder",
                            style: TextStyle(
                                color: Color.fromRGBO(37, 42, 49, 1.0),
                                fontSize: 18)),
                        ToggleButton(
                            onTap: widget.toggleTime, isActive: widget.setTime),
                      ])),
            ))
        : Container();

    Widget datePicker = widget.setDate
        ? DateTimePicker(
            initialDateTime: widget.event.time,
            mode: CupertinoDatePickerMode.date,
            onChangeDateTime: (DateTime date) {
              setState(() {
                widget.event.date = date;
              });
            })
        : Container();

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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_eventTitle,
                          style: TextStyle(
                              color: Color.fromRGBO(37, 42, 49, 1.0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      DoneButton(onTap: widget.closeSetting, isActive: true)
                    ])),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Set date reminder",
                              style: TextStyle(
                                  color: Color.fromRGBO(37, 42, 49, 1.0),
                                  fontSize: 18)),
                          ToggleButton(
                              onTap: widget.toggleDate,
                              isActive: widget.setDate),
                        ])),
              )),
          Column(children: <Widget>[datePicker, toggleTimeBar, timePicker])
        ]));
  }
}
