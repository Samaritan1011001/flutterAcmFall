import 'package:flutterAcmFall/model/objects/AppUser.dart';

class Event {
  String title;
  String group;
  DateTime date;
  DateTime time;
  bool isDone;
  AppUser user;

  Event({this.title, this.group, this.date, this.time, this.isDone, this.user});

  String toString() {
    return '{title: ${this.title}, group: ${this.group}, date: ${this.date}, time: ${this.time}, isDone: ${this.isDone}, user: $user}';
  }
}
