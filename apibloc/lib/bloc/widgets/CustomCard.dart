import 'package:flutter/material.dart';

class Customcard extends StatefulWidget {
  const Customcard(
      {super.key,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.enrolled,
      required this.onPressed});

  final VoidCallback onPressed;
  final int id;
  final String firstName;
  final String lastName;
  final bool enrolled;

  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 131, 228, 134),
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: Colors.black, width: 3)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("First Name: ${widget.firstName}"),
            const SizedBox(height: 10),
            Text("Last Name: ${widget.lastName}"),
            const SizedBox(height: 10),
            Text("Enrolled: ${widget.enrolled}"),
            const SizedBox(height: 10),
            Center(
                child: TextButton(
                    onPressed: widget.onPressed, child: const Text("View")))
          ],
        ),
      ),
    );
  }
}
