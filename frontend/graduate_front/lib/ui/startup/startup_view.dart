import 'package:flutter/material.dart';
import 'package:graduate_front/ui/startup/startup_viewmodel%20.dart';
import 'package:stacked/stacked.dart';

import 'bb.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (viewmodel) => viewmodel.checkUser(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
