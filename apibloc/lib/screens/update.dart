import 'package:apibloc/bloc/bloc.dart';
import 'package:apibloc/bloc/event.dart';
import 'package:apibloc/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class updateRequest extends StatefulWidget {
  const updateRequest(
      {super.key,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.course,
      required this.year,
      required this.enrolled});

  final int id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  @override
  State<updateRequest> createState() => _updateRequestState();
}

class _updateRequestState extends State<updateRequest> {
  late StudentBloc studentBloc;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  String? year = 'First Year';
  bool enrolled = false;

  @override
  void initState() {
    super.initState();
    studentBloc = StudentBloc();

    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    courseController.text = widget.course;
    year = widget.year;
    enrolled = widget.enrolled;
  }

  @override
  void dispose() {
    studentBloc.close();
    firstNameController.dispose();
    lastNameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  bool validateFields() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String course = courseController.text;

    if (firstName.isEmpty) {
      _showSnackBar('Please enter first name');
      return false;
    } else if (firstName.length > 15) {
      _showSnackBar('First name must be at most 15 characters');
      return false;
    }

    if (lastName.isEmpty) {
      _showSnackBar('Please enter last name');
      return false;
    } else if (lastName.length > 15) {
      _showSnackBar('Last name must be at most 15 characters');
      return false;
    }

    if (course.isEmpty) {
      _showSnackBar('Please enter course');
      return false;
    } else if (course.length > 10) {
      _showSnackBar('Course must be at most 10 characters');
      return false;
    }

    if (year == null || year!.isEmpty) {
      _showSnackBar('Please select a year');
      return false;
    } else if (year!.length > 20) {
      _showSnackBar('Year must be at most 20 characters');
      return false;
    }

    if (enrolled == null) {
      _showSnackBar('Enrolled status must be set');
      return false;
    }

    return true;
  }

  void _showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Student'),
          backgroundColor: Colors.blue,
        ),
        body: BlocConsumer<StudentBloc, state>(
          listener: (context, state) {
            if (state is studentUpdated) {
              _showSnackBar('Student added successfully');
            } else if (state is studentError) {
              _showSnackBar('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                TextFormField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: 'Course'),
                ),
                DropdownButtonFormField<String>(
                  value: year,
                  onChanged: (String? newValue) {
                    setState(() {
                      year = newValue;
                    });
                  },
                  items: [
                    'First Year',
                    'Second Year',
                    'Third Year',
                    'Fourth Year'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Year'),
                ),
                SwitchListTile(
                  title: const Text('Enrolled'),
                  value: enrolled,
                  onChanged: (bool value) {
                    setState(() {
                      enrolled = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (validateFields()) {
                      context.read<StudentBloc>().add(updateStudent(
                            firstNameController.text,
                            lastNameController.text,
                            courseController.text,
                            year!,
                            enrolled,
                            widget.id,
                          ));
                      await Future.delayed(Duration(milliseconds: 300));
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
