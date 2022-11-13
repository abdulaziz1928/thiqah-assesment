import 'dart:convert';

import 'package:graduate_front/core/models/program.dart';
import 'package:graduate_front/core/services/image_service.dart';
import 'package:graduate_front/core/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final userService = locator<UserService>();
  final imageService = ImageService();
  static const baseUrl = "http://10.0.2.2:3000/";
  final Map<String, String> header = {
    "Content-type": "application/json",
    "Accept": "application/json",
  };
  hasProgram() async {
    try {
      String jwt = await getJWT();
      final Map<String, String> pHeader = header;
      pHeader["authorization"] = jwt;
      User tUsr = await getUserInstance(jwt);
      pHeader['email'] = tUsr.email;
      final result = await http.get(
        Uri.parse("${baseUrl}program/show"),
        headers: pHeader,
      );
      if (result.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  registerProgram(GraduateProgram program) async {
    //  TODO
    try {
      String jwt = await getJWT();
      final Map<String, String> pHeader = header;
      pHeader["authorization"] = jwt;
      final body = {
        "email": program.email,
        "level": program.level,
        "program": program.program,
        "faculty": program.faculty
      };
      final result = await http.post(
        Uri.parse("${baseUrl}program"),
        body: jsonEncode(body),
        headers: pHeader,
      );
      if (result.statusCode != 200) {
        throw Exception(
            'Program Registration Error: status Code: ${result.statusCode}');
      }
      await userService.updateUser(jwt);
    } catch (e) {
      print('AuthService: Program Register Error: $e');
      rethrow;
    }
  }

  register({required User usr, required String pass}) async {
    try {
      Uri url = Uri.parse("${baseUrl}users");
      Map<String, dynamic> body;
      String? img_path;
      if (usr.photo != null) {
        img_path = await imageService.uploadImage(usr.photo!);
        body = {
          "email": usr.email,
          "firstname": usr.fName,
          "lastname": usr.lName,
          "birthday": usr.birthday,
          "photo": img_path,
          "password": pass
        };
      } else {
        body = {
          "email": usr.email,
          "firstname": usr.fName,
          "lastname": usr.lName,
          "birthday": usr.birthday,
          "password": pass
        };
      }

      final result =
          await http.post(url, body: jsonEncode(body), headers: header);

      if (usr.photo != null) {}
      if (result.statusCode != 200) {
        throw Exception(
            'Registration Error: status Code: ${result.statusCode}');
      }
      String jwt = jsonDecode(result.body.toString())['token'];
      _saveJWT(jwt);
      checkUser(jwt);
    } catch (e) {
      print('AuthService: Register Error: $e');
      rethrow;
    }
  }

  login({required String email, required String password}) async {
    try {
      //  TODO call login function
      Uri url = Uri.parse("${baseUrl}auth/$email/$password");
      final result = await http.get(
        url,
        headers: header,
      );
      if (result.statusCode != 200) {
        throw Exception(
            'invalid email/password: status Code: ${result.statusCode}');
      }
      String jwt = jsonDecode(result.body.toString())['token'];
      _saveJWT(jwt);
      //  Init user
      checkUser(jwt);
    } catch (e) {
      print('AuthService: Login Error: $e');
      rethrow;
    }
  }

  checkUser(String jwt) {
    try {
      userService.initUser(jwt);
    } catch (e) {
      print('AuthService: Check User Error: $e');
      rethrow;
    }
  }

  Future<User> getUserInstance(String jwt) async {
    return userService.updatedUser(jwt);
  }

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SESSION_KEY");
    userService.sI = false;
  }

  _saveJWT(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("SESSION_KEY", jwt);
  }

  Future<String> getJWT() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jwt = prefs.getString("SESSION_KEY");

      if (jwt == null) {
        throw Exception('jwt not found');
      }
      return jwt;
    } catch (e) {
      rethrow;
    }
  }
}
