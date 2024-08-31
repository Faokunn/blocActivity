import 'package:flutter/widgets.dart';

class updateRequest extends StatefulWidget {
  const updateRequest(
      {super.key,
      required int id,
      required String firstName,
      required String lastName,
      required String course,
      required String year,
      required bool enrolled});

  @override
  State<updateRequest> createState() => _updateRequestState();
}

class _updateRequestState extends State<updateRequest> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
