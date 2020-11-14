import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutterAcmFall/model/objects/Event.dart';
import 'package:flutterAcmFall/model/objects/User.dart';

class MockData {
  DateTime createRandomDate(Random gen, int range) {
    int addOrSub = gen.nextInt(2);
    DateTime randomDate = addOrSub == 0
        ? DateTime.now().subtract(Duration(days: gen.nextInt(range)))
        : DateTime.now().add(Duration(days: gen.nextInt(range)));
    return randomDate;
  }

  DateTime createRandomTime(Random gen, int range) {
    int addOrSub = gen.nextInt(2);
    DateTime randomDate = addOrSub == 0
        ? DateTime.now().subtract(
            Duration(hours: gen.nextInt(range), minutes: gen.nextInt(range)))
        : DateTime.now().add(
            Duration(hours: gen.nextInt(range), minutes: gen.nextInt(range)));
    return randomDate;
  }

  List<Event> getDataList() {
    List<String> titles = [
      "Do homework",
      "Do project",
      "Take out the trash",
      "Cook dinner",
      "Wash clothes",
      "Go to sleep"
    ];

    List<User> users = [
      User(id: "12345", color: Color.fromRGBO(97, 222, 164, 1.0)),
      User(id: "1234", color: Color.fromRGBO(0, 108, 255, 1.0)),
      User(id: "123", color: Color.fromRGBO(182, 120, 255, 1.0)),
      User(id: "12", color: Color.fromRGBO(255, 231, 97, 1.0)),
    ];

    List<Event> events = [];

    for (int i = 0; i < users.length; i++) {
      for (int j = 0; j < titles.length; j++) {
        Random gen = Random();
        DateTime randomDate = createRandomDate(gen, 100);
        DateTime randomTime = createRandomTime(gen, 12);
        Event event = Event(
            title: titles[j],
            date: randomDate,
            time: randomTime,
            isDone: false,
            user: users[i]);

        events.add(event);
      }
    }

    return events;
  }
}
