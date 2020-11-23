import 'package:flutter/material.dart';

class User {
  String id;
  Color color;

  User({this.id, this.color});

  String toString() {
    return '{userID: ${this.id}, color: ${this.color}}';
  }
}