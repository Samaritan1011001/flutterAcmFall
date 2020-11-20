import 'package:flutter/material.dart';

class AppUser {
  String id;
  String group;
  Color color;

  AppUser({this.id, this.group, this.color});

  String toString() {
    return '{userID: ${this.id}, group: ${this.group}, color: ${this.color}}';
  }
}
