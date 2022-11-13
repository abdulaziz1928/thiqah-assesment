import 'package:graduate_front/core/app/app.router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/user.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/user_service.dart';

class StartUpViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<UserService>();
  final authService = locator<AuthService>();

  checkUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jwt = prefs.getString("SESSION_KEY");
    try {
      if (jwt != null) {
        await userService.initUser(jwt);

        bool hP = await authService.hasProgram();
        if (hP) {
          navService.navigateTo(Routes.profileView);
        } else {
          navService.navigateTo(Routes.programRegistrationView);
        }
      } else {
        navService.navigateTo(Routes.welcomeView);
      }
    } catch (e) {
      print('$e');
      navService.navigateTo(Routes.welcomeView);
    }
  }
}
