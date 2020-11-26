import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventSettingScreen extends StatefulWidget {
  EventSettingScreen(
      {Key key,
      this.event,
      this.controller,
      this.isEditExistedEvent,
      this.isOpen,
      this.closeSetting})
      : super(key: key);

  final Event event;
  final TextEditingController controller;
  final bool isEditExistedEvent;
  final bool isOpen;
  final Function closeSetting;

  _EventSettingScreen createState() => _EventSettingScreen();
}

class _EventSettingScreen extends State<EventSettingScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  void _toggleDate() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      if (widget.event.date != null) {
        widget.event.date = null;
        widget.event.time = null;
      } else {
        widget.event.date = DateTime.now();
      }
    });
  }

  void _toggleTime() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      if (widget.event.time != null) {
        widget.event.time = null;
      } else {
        widget.event.time = DateTime.now();
      }
    });
  }

  void _handleChangeTitle(String title) {
    setState(() {
      widget.event.title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget timePicker = widget.event.time != null
        ? DateTimePicker(
            initialDateTime: widget.event.time,
            mode: CupertinoDatePickerMode.time,
            onChangeDateTime: (DateTime time) {
              setState(() {
                widget.event.time = time;
              });
            })
        : Container();

    Widget toggleTimeBar = widget.event.date != null
        ? Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 50,
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
                            onTap: _toggleTime,
                            isActive: widget.event.time != null),
                      ])),
            ))
        : Container();

    Widget datePicker = widget.event.date != null
        ? DateTimePicker(
            initialDateTime: widget.event.date,
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
        height: MediaQuery.of(context).size.height,
        transform: Matrix4.translationValues(
            0, widget.isOpen ? 0 : MediaQuery.of(context).size.height, 1),
        decoration: BoxDecoration(color: Color.fromRGBO(235, 239, 245, 1.0)),
        child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                actions: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                      child: TextExitButton(
                          text: "Done",
                          fontWeight: FontWeight.bold,
                          onTap: () {
                            DateTime timeUpdated = DateTime.now();
                            if (widget.isEditExistedEvent) {
                              firestoreInstance
                                  .collection("events")
                                  .doc(widget.event.id)
                                  .update({
                                "title": widget.event.title,
                                "date": widget.event.date,
                                "time": widget.event.time,
                                "isDone": widget.event.isDone,
                                "user": widget.event.user.id,
                                "group": widget.event.user.group,
                              });
                              firestoreInstance
                                  .collection("users")
                                  .doc(widget.event.user.id)
                                  .update({
                                "events.${widget.event.id}": timeUpdated
                              });
                              firestoreInstance
                                  .collection("groups")
                                  .doc(widget.event.user.group)
                                  .update({
                                "share_events.${widget.event.id}": timeUpdated
                              });
                            }
                            widget.closeSetting();
                          },
                          isActive: true))
                ]),
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                          height: 50,
                          color: Colors.white,
                          child: TextFormField(
                            controller: widget.controller,
                            onChanged: _handleChangeTitle,
                            decoration: InputDecoration(
                                hintText: "What do you want to do?",
                                hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 5.0)),
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(37, 42, 49, 1.0)),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Set date reminder",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(37, 42, 49, 1.0),
                                          fontSize: 18)),
                                  ToggleButton(
                                      onTap: _toggleDate,
                                      isActive: widget.event.date != null),
                                ])),
                      )),
                  datePicker,
                  toggleTimeBar,
                  timePicker
                ])))));
  }
}
