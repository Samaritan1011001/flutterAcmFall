class AppUser {
  String id;
  String group;
  String photo;

  AppUser({this.id, this.group, this.photo});

  String toString() {
    return '{id: ${this.id}, group: ${this.group}, photo: ${this.photo}}';
  }
}
