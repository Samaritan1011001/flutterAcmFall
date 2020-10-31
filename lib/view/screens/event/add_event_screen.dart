import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/view/screens/event/event_setting_screen.dart';

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
  Event _event =
      Event(id: null, title: null, date: null, time: null, isDone: false);

  TextEditingController _controller = TextEditingController();

  bool _openMoreSetting = false;

  void initState() {
    super.initState();
    _controller = TextEditingController(text: _event.title);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangeEventTitle(String title) {
    setState(() {
      _event.title = title;
    });
  }

  void _toggleMoreSetting() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _openMoreSetting = !_openMoreSetting;
      _controller.text = _event.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget dateText =
        _event.date != null ? EventDateFormat(date: _event.date) : Container();

    Widget timeText = _event.time != null
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
                    TextExitButton(
                        text: "Cancel",
                        fontWeight: FontWeight.normal,
                        onTap: () {
                          widget.closeScreen(null);
                        },
                        isActive: true),
                    TextExitButton(
                      text: "Done",
                      fontWeight: (_event.title != null
                              ? _event.title.trim() != ""
                              : false)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (_event.title != null) {
                          if (_event.title.trim() != "") {
                            widget.closeScreen(_event);
                          }
                        }
                      },
                      isActive: (_event.title != null
                          ? _event.title.trim() != ""
                          : false),
                    ),
                  ])),
          Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 20.0),
              child: Row(children: <Widget>[
                RadioButton(
                    onTap: () {
                      setState(() {
                        _event.isDone = !_event.isDone;
                      });
                    },
                    isActive: _event.isDone),
                Expanded(
                    child: TextFormField(
                  controller: _controller,
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
        EventSettingScreen(
          event: _event,
          controller: _controller,
          isOpen: _openMoreSetting,
          closeSetting: _toggleMoreSetting,
        ),
      ]),
    )));
  }
}
