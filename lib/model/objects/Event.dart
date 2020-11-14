import 'package:flutterAcmFall/model/objects/User.dart';

class Event {
  String title;
  DateTime date;
  DateTime time;
  bool isDone;
  User user;

  Event({this.title, this.date, this.time, this.isDone, this.user});

  String toString() {
    return '{title: ${this.title}, date: ${this.date}, time: ${this.time}, isDone: ${this.isDone}, user: $user}';
  }
}
