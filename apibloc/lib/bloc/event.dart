abstract class event {}

class getStudent extends event {}

class showStudent extends event {
  final int id;

  showStudent(this.id);
}

class deleteStudent extends event {
  final int id;

  deleteStudent(this.id);
}
