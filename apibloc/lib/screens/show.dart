import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apibloc/bloc/bloc.dart';
import 'package:apibloc/bloc/event.dart';
import 'package:apibloc/bloc/state.dart';
import 'package:apibloc/screens/update.dart';

class ShowRequest extends StatelessWidget {
  final int id;

  const ShowRequest({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment Three: Read"),
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider(
        create: (context) => StudentBloc()..add(showStudent(id)),
        child: BlocBuilder<StudentBloc, state>(
          builder: (context, state) {
            if (state is studentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is specificStudentLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("First Name: ${state.student.firstName}"),
                    Text("Last Name: ${state.student.lastName}"),
                    Text("Course: ${state.student.course}"),
                    Text("Year: ${state.student.year}"),
                    Text("Enrolled: ${state.student.enrolled.toString()}"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => updateRequest(
                              id: state.student.id,
                              firstName: state.student.firstName,
                              lastName: state.student.lastName,
                              course: state.student.course,
                              year: state.student.year,
                              enrolled: state.student.enrolled,
                            ),
                          ),
                        );
                        if (result == true) {
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text("Update"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        context
                            .read<StudentBloc>()
                            .add(deleteStudent(state.student.id));
                        await Future.delayed(Duration(milliseconds: 300));
                        Navigator.pop(context, true);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            } else if (state is studentError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('No student available'));
            }
          },
        ),
      ),
    );
  }
}
