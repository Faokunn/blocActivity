import 'package:apibloc/bloc/bloc.dart';
import 'package:apibloc/bloc/event.dart';
import 'package:apibloc/bloc/state.dart';
import 'package:apibloc/bloc/widgets/CustomCard.dart';
import 'package:apibloc/screens/show.dart';
import 'package:apibloc/screens/create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class readRequest extends StatelessWidget {
  const readRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
      ),
      body: BlocBuilder<StudentBloc, state>(
        builder: (context, state) {
          if (state is studentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is studentLoaded) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return Customcard(
                  id: student.id,
                  firstName: student.firstName,
                  lastName: student.lastName,
                  enrolled: student.enrolled,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowRequest(id: student.id),
                      ),
                    );
                    if (result == true) {
                      context.read<StudentBloc>().add(getStudent());
                    } else {
                      context.read<StudentBloc>().add(getStudent());
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No students available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => createRequest(),
            ),
          );
          if (result == true) {
            context.read<StudentBloc>().add(getStudent());
          } else {
            context.read<StudentBloc>().add(getStudent());
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Create Request',
      ),
    );
  }
}
