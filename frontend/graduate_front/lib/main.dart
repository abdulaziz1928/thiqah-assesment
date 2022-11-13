import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/app/app.locator.dart';
import 'core/app/app.router.dart';
import 'core/models/user.dart';
import 'core/services/user_service.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (_) => locator<UserService>().userController.stream,
            initialData: User.anonymous())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.lightBlue),
            primarySwatch: Colors.lightBlue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}
