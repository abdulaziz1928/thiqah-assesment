import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_front/core/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<AuthService>();
  String? email;
  String? password;
  bool isNumber = false;

  final formKey = GlobalKey<FormState>();
  navigateToNavigation() {
    // navService.navigateTo(Routes.navigationView);
  }
  hasProgram() async {
    bool hP = await userService.hasProgram();
    if (hP) {
      navService.clearStackAndShow(Routes.profileView);
    } else {
      navService.clearStackAndShow(Routes.programRegistrationView);
    }
  }

  Future<void> loginAndNavigate(context) async {
    try {
      await userService.login(email: email!, password: password!);
      hasProgram();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Login Error $e',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  submitLogin(context) {
    if (!formKey.currentState!.validate()) {
      print('Login Failed : invalid login information');
      return;
    }
    formKey.currentState?.save();
    loginAndNavigate(context);
    notifyListeners();
  }
}
