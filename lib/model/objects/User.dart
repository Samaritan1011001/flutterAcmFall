import 'package:flutter/material.dart';

class User {
  String id;
  String group;

  User({this.id, this.group});

  String toString() {
    return '{id: ${this.id}, group: ${this.group}}';
  }
}