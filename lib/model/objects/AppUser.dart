class AppUser {
  String id;
  String group;
  String photoUrl;

  AppUser({this.id, this.group});

  String toString() {
    return '{userID: ${this.id}, group: ${this.group}}';
  }
}
