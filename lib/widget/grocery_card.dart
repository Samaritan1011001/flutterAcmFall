import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/screens/grocChecklistScreen.dart';
import 'package:flutterAcmFall/widget/grocery_utils.dart';

class GroceryCard extends StatefulWidget {
  GroceryCard(
      {Key key,
        this.grocery,
        this.user,
        this.modeIsEdit,
        this.onClickEvent,
        this.onDeleteEvent})
      : super(key: key);

  final Grocery grocery;
  final User user;
  final bool modeIsEdit;
  final Function onClickEvent;
  final Function onDeleteEvent;

  _GroceryCard createState() => _GroceryCard();
}

class _GroceryCard extends State<GroceryCard> {
  @override
  Widget build(BuildContext context) {
    String title = (widget.grocery.title.length >= 25)
        ? '${widget.grocery.title.substring(0, 25)}...'
        : widget.grocery.title;

    Color titleColor =
    widget.grocery.isDone ? Colors.grey : Color.fromRGBO(37, 42, 49, 1.0);

    Widget dateText = widget.grocery.date != null
        ? Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: EventDateFormat(date: widget.grocery.date))
        : Container();


    return // debug
      Container(
          height: 70,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(235, 239, 245, 1.0), width: 2))),
          child: InkWell(
              onTap: () {
                widget.onClickEvent(widget.grocery);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(children: <Widget>[
                    RadioButton(
                      onTap: () {
                        setState(() {
                          widget.grocery.isDone = !widget.grocery.isDone;
                        });
                      },
                      isActive: widget.grocery.isDone,
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
                                              fontSize: 20,
                                              color: titleColor))),
                                  Row(children: <Widget>[dateText]),
                                ]))),
                    widget.modeIsEdit &&
                        widget.user.id == widget.grocery.user.id
                        ? DeleteButton(
                      onTap: () {
                        widget.onDeleteEvent(widget.grocery);
                      },
                      isActive: true,
                    )
                        : Icon(Icons.lens_rounded,
                        size: 15, color: widget.grocery.user.color)
                  ]))));
  }
}