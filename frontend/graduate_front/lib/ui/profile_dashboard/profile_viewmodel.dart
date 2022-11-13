import 'package:graduate_front/core/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/auth_service.dart';

class ProfileViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<AuthService>();
  signout() {
    userService.signOut();
    navService.clearStackAndShow(Routes.welcomeView);
  }
}
