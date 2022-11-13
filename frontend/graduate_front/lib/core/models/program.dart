class GraduateProgram {
  final String? id;
  final String? email;
  final String level;
  final String program;
  final String faculty;

  GraduateProgram(
      {this.id,
      this.email,
      required this.level,
      required this.program,
      required this.faculty});

  factory GraduateProgram.fromJson(Map<String, dynamic> map) {
    return GraduateProgram(
        id: map['id']?.toString() ?? '',
        level: map['level_study'].toString(),
        program: map['program'].toString(),
        faculty: map['faculty'].toString());
  }

  factory GraduateProgram.anonymous() {
    return GraduateProgram(
      level: "test_level",
      program: "test_program",
      faculty: "test_faculty",
    );
  }
}
