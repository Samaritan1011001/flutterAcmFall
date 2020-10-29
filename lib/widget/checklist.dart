import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Done extends StatelessWidget{
  Done({Key key, this.onTap, this.isActive}):super(key:key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text("Done",
          style:TextStyle(
            color:
              isActive ? Color.fromRGBO(0,108,255,1.0):Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ))

    );

  }
}

class Cancel extends StatelessWidget{
  Cancel({Key key, this.onTap, this.isActive}) : super(key:key);
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text("Cancel",
          style: TextStyle(
            color: isActive ? Color.fromRGBO(0, 108, 255, 1.0): Colors.grey,
            fontSize:18,
          ))
    );

  }
}

