import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const baseUrl = "http://10.0.2.2:3000/";
  late BehaviorSubject<User> userController;
  bool sI = false;
  Future<void> initUser(String jwt) async {
    userController = BehaviorSubject<User>();
    final initialData = await getUser(jwt);
    userController.sink.add(initialData);
    sI = true;

    Timer.periodic(Duration(seconds: 30), (timer) async {
      if (!sI) {
        userController.sink.add(User.anonymous());
        timer.cancel();
      } else {
        final initialData = await getUser(jwt);
        userController.sink.add(initialData);
      }
    });
  }

  Future<User> getUser(String jwt) async {
    Uri url = Uri.parse("${baseUrl}users/account");
    final Map<String, String> header = {
      "Accept": "application/json",
      "authorization": jwt
    };
    final result = await http.get(
      url,
      headers: header,
    );
    final Map<String, dynamic> decoded = jsonDecode(result.body);


    header['email'] = decoded['email'];
    final result2 = await http.get(
      Uri.parse("${baseUrl}program/show"),
      headers: header,
    );

    if (result2.statusCode == 200) {
      decoded['program'] = jsonDecode(result2.body);

    }
    User usr = User.fromJson(decoded);
    return usr;
  }

  Future<User> updatedUser(String jwt) async {
    Uri url = Uri.parse("${baseUrl}users/account");
    final Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "authorization": jwt
    };
    final result = await http.get(
      url,
      headers: header,
    );
    final Map<String, dynamic> decoded = jsonDecode(result.body.toString());
    return User.fromJson(decoded);
  }

  Future<void> updateUser(String jwt) async {
    final updatedData = await getUser(jwt);
    userController.sink.add(updatedData);
  }
}
