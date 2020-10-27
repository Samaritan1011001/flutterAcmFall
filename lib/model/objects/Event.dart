class Event {
  int id;
  String title;
  DateTime date;
  DateTime time;
  bool isDone;

  Event({this.id, this.title, this.date, this.time, this.isDone});

  String toString() {
    return '$id: {title: ${this.title}, date: ${this.date}, time: ${this.time}, isDone: ${this.isDone}}';
  }
}
