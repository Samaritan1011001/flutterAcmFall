import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/widget/event_utils.dart';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventCard extends StatefulWidget {
  EventCard({
    Key key,
    this.event,
    this.user,
    this.modeIsEdit,
    this.onClickEvent,
  }) : super(key: key);

  final Event event;
  final AppUser user;
  final bool modeIsEdit;
  final Function onClickEvent;

  _EventCard createState() => _EventCard();
}

class _EventCard extends State<EventCard> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String title = (widget.event.title.length > 30)
        ? '${widget.event.title.substring(0, 30)}...'
        : widget.event.title;

    Color titleColor =
        widget.event.isDone ? Colors.grey : Color.fromRGBO(37, 42, 49, 1.0);

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

    return Container(
        height: 70,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color.fromRGBO(235, 239, 245, 1.0), width: 2))),
        child: InkWell(
            onTap: () {
              widget.onClickEvent(widget.event);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(children: <Widget>[
                  RadioButton(
                    onTap: () {
                      setState(() {
                        widget.event.isDone = !widget.event.isDone;
                        firestoreInstance
                            .collection("events")
                            .doc(widget.event.id)
                            .update({"isDone": widget.event.isDone});
                      });
                    },
                    isActive: widget.event.isDone,
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text(title,
                                        style: TextStyle(
                                            fontSize: 18, color: titleColor))),
                                Row(children: <Widget>[dateText, timeText]),
                              ]))),
                  widget.modeIsEdit && widget.user.id == widget.event.user.id
                      ? Container(
                          width: 35,
                          height: 35,
                          child: DeleteButton(
                            onTap: () {
                              firestoreInstance
                                  .collection("events")
                                  .doc(widget.event.id)
                                  .update({"isActive": false});
                            },
                            isActive: true,
                          ))
                      : (widget.event.user.photo != null
                          ? Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          widget.event.user.photo))))
                          : Container())
                ]))));
  }
}
