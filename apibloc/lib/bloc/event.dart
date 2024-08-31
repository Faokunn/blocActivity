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

class updateStudent extends event {
  final int id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  updateStudent(this.firstName, this.lastName, this.course, this.year,
      this.enrolled, this.id);
}

class createStudent extends event {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  createStudent(
      this.firstName, this.lastName, this.course, this.year, this.enrolled);
}
