import 'dart:convert';
import 'package:apibloc/bloc/event.dart';
import 'package:apibloc/bloc/state.dart';
import 'package:apibloc/model/student.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class StudentBloc extends Bloc<event, state> {
  StudentBloc() : super(studentLoading()) {
    on<getStudent>(fetchStudentData);
    on<deleteStudent>(deleteStudentData);
    on<showStudent>(showStudentData);
    on<updateStudent>(updateStudentData);
    on<createStudent>(createStudentData);
  }

  Future<void> deleteStudentData(
      deleteStudent event, Emitter<state> emit) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.id}'),
      );

      if (response.statusCode == 200) {
        add(getStudent());
      } else {
        emit(studentError('Failed to delete student with ID: ${event.id}'));
      }
    } catch (e) {
      emit(studentError('Error deleting student: ${e.toString()}'));
    }
  }

  Future<void> fetchStudentData(getStudent event, Emitter<state> emit) async {
    emit(studentLoading());

    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/students'));

      if (response.statusCode == 200) {
        List<dynamic> studentsJson = json.decode(response.body)['students'];
        List<Students> students =
            studentsJson.map((json) => Students.fromJson(json)).toList();
        emit(studentLoaded(students));
      } else {
        emit(studentError('Failed to load students'));
      }
    } catch (e) {
      emit(studentError(e.toString()));
    }
  }

  Future<void> showStudentData(showStudent event, Emitter<state> emit) async {
    emit(studentLoading());
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.id}'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> studentJson =
            json.decode(response.body)['student'];
        Students student = Students.fromJson(studentJson);
        emit(specificStudentLoaded(student));
      } else {
        emit(studentError('Failed to load student'));
      }
    } catch (e) {
      emit(studentError(e.toString()));
    }
  }

  Future<void> updateStudentData(
      updateStudent event, Emitter<state> emit) async {
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.id}'),
        //Uri.parse('http://10.0.2.2:8000/api/students/${event.id}'),
        // Uri.parse('http://localhost:8000/api/students/${event.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'FirstName': event.firstName,
          'LastName': event.lastName,
          'Course': event.course,
          'Year': event.year,
          'Enrolled': event.enrolled,
        }),
      );

      if (response.statusCode == 200) {
        emit(studentUpdated());
        await showStudentData(showStudent(event.id), emit);
      } else {
        emit(studentError('Failed to update student'));
      }
    } catch (e) {
      emit(studentError(e.toString()));
    }
  }

  Future<void> createStudentData(
      createStudent event, Emitter<state> emit) async {
    emit(studentLoading());

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/students'),
        //Uri.parse('http://10.0.2.2:8000/api/students'),
        //Uri.parse('http://localhost:8000/api/students'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'FirstName': event.firstName,
          'LastName': event.lastName,
          'Course': event.course,
          'Year': event.year,
          'Enrolled': event.enrolled,
        }),
      );

      if (response.statusCode == 200) {
        emit(studentUpdated());
        add(getStudent());
      } else {
        emit(studentError('Failed to add student'));
      }
    } catch (e) {
      emit(studentError(e.toString()));
    }
  }
}
