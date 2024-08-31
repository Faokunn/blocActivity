import 'package:apibloc/model/student.dart';

abstract class state {}

class studentLoading extends state {}

class studentLoaded extends state {
  final List<Students> students;
  studentLoaded(this.students);
}

class studentError extends state {
  final String error;
  studentError(this.error);
}

class studentDelete extends state {
  final int id;

  studentDelete(this.id);
}

class specificStudentLoaded extends state {
  final Students student;

  specificStudentLoaded(this.student);
}

class studentUpdated extends state {}

class studentCreated extends state {}
