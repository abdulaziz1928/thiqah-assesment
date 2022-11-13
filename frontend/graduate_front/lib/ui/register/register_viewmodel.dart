import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/user.dart';
import '../../core/services/auth_service.dart';

class RegisterViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final userService = locator<AuthService>();
  final navService = locator<NavigationService>();
  String? email;
  String? fName;
  String? lName;
  String? bDay;
  String? password;
  File? photo;
  registerAndNavigate(context) async {
    try {
      User rUsr = User(
          email: email!,
          fName: fName!,
          lName: lName!,
          birthday: bDay!,
          photo: photo);
      await userService.register(usr: rUsr, pass: password!);
      setBusy(false);
      navService.clearStackAndShow(Routes.programRegistrationView);
    } catch (e) {
      setBusy(false);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Registration Error $e',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  submitRegistration(context) async {
    if (!formKey.currentState!.validate()) {
      print('Register Failed : invalid Registration information');
      return;
    }
    setBusy(true);
    formKey.currentState?.save();
    registerAndNavigate(context);
    notifyListeners();
    setBusy(false);
  }
}
