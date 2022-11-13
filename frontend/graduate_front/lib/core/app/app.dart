import 'package:graduate_front/core/services/auth_service.dart';
import 'package:graduate_front/ui/login/login_view.dart';
import 'package:graduate_front/ui/welcome/welcome_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../ui/profile_dashboard/profile_view.dart';
import '../../ui/program/program_registration_view.dart';
import '../../ui/register/register_view.dart';
import '../../ui/startup/startup_view.dart';
import '../services/user_service.dart';

@StackedApp(routes: [
  // Register all views
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: WelcomeView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: ProfileView),
  MaterialRoute(page: ProgramRegistrationView),
], dependencies: [
  // Register all Services
  LazySingleton<NavigationService>(classType: NavigationService),
  LazySingleton<AuthService>(classType: AuthService),
  LazySingleton<UserService>(classType: UserService),
])
class AppSetup {}
