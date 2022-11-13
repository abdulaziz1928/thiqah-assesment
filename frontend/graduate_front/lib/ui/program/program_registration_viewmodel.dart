import 'package:flutter/material.dart';
import 'package:graduate_front/core/models/program.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/services/auth_service.dart';

class ProgramRegistrationViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<AuthService>();
  final formKey = GlobalKey<FormState>();
  String? levListVal, pListVal, fListVal, email;

  submitProgram(context) async {
    if (!formKey.currentState!.validate()) {
      print('Application Failed : invalid items information');
      return;
    }
    formKey.currentState?.save();
    GraduateProgram program = GraduateProgram(
        email: email!,
        program: pListVal!,
        level: levListVal!,
        faculty: fListVal!);
    try {
      await userService.registerProgram(program);
      navService.clearStackAndShow(Routes.profileView);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Program Registration Error $e',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }
}
