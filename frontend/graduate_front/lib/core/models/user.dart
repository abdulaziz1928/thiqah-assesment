import 'dart:convert';
import 'dart:io';

import 'package:graduate_front/core/models/program.dart';

class User {
  final String? id;
  final String email;
  final String fName;
  final String lName;
  final String birthday;
  final File? photo;
  final String? pPath;
  final GraduateProgram? gProgram;

  User(
      {this.id,
      required this.email,
      required this.fName,
      required this.lName,
      required this.birthday,
      this.photo,
      this.pPath,
      this.gProgram});

  factory User.anonymous() {
    return User(
        email: "test@test.com",
        fName: "test",
        lName: "me",
        birthday: "01/01/1900");
  }
  factory User.fromJson(Map<String, dynamic> map) {
    print('dddddddddddd');
    return User(
        id: map['id']!.toString(),
        email: map['email'].toString(),
        fName: map['firstname'].toString(),
        lName: map['lastname'].toString(),
        pPath: map['photo'],
        birthday: map['birthday'].toString(),
        gProgram: map["program"] == null
            ? GraduateProgram.anonymous()
            : GraduateProgram.fromJson(map['program']));
  }
}
