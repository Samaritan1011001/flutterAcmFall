import 'package:flutter/material.dart';
import 'package:flutterAcmFall/model/objects/User.dart';
import 'package:flutterAcmFall/view/screens/grocery/grocChecklistScreen.dart';
import 'package:intl/intl.dart';

import 'grocery_card.dart';

class GroceryList extends StatefulWidget {
  GroceryList(
      {Key key,
      this.grocery,
      this.user,
      this.modeIsEdit,
      this.handleClickEvent,
      this.handleDeleteEvent})
      : super(key: key);

  final List<Grocery> grocery;
  final User user;
  final bool modeIsEdit;
  final Function handleClickEvent;
  final Function handleDeleteEvent;

  _GroceryList createState() => _GroceryList();
}

class _GroceryList extends State<GroceryList> {
  Widget build(BuildContext context) {
    widget.grocery.sort((Grocery a, Grocery b) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateFormat timeFormat = DateFormat("HH:mm:ss");

      String dateA = dateFormat.format(a.checklist.date).toString();

      DateTime dateTimeA = DateTime.parse(dateA);

      String dateB = dateFormat.format(b.checklist.date).toString();

      DateTime dateTimeB = DateTime.parse(dateB);

      return dateTimeA.compareTo(dateTimeB);
    });
    return SingleChildScrollView(
      child: Column(
          children: widget.grocery
              .map((grocery) => GroceryCard(
                  grocery: grocery,
                  user: widget.user,
                  modeIsEdit: widget.modeIsEdit,
                  onClickEvent: widget.handleClickEvent,
                  onDeleteEvent: widget.handleDeleteEvent))
              .toList()),
    );
  }
}
