import 'package:graduate_front/core/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';

class WelcomeViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  navigateToRegister() {
    navService.navigateTo(Routes.registerView);
  }

  navigateToLogin() {
    navService.navigateTo(Routes.loginView);
  }
}
