class Students {
  final int id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  Students({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        course: json['course'],
        year: json['year'],
        enrolled: json['enrolled']);
  }
}
