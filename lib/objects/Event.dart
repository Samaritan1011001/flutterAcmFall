class Event {
  String title;
  DateTime date;
  DateTime time;
  bool isDone;

  Event({this.title, this.date, this.time, this.isDone});

  String toString() {
    return '{title: ${this.title}, date: ${this.date}, time: ${this.time}, isDone: ${this.isDone}}';
  }
}
