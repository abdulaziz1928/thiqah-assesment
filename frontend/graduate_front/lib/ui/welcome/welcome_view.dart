import 'package:flutter/material.dart';
import 'package:graduate_front/core/utils/styles.dart';
import 'package:graduate_front/ui/welcome/welcome_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../startup/bb.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
        viewModelBuilder: () => WelcomeViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Welcome Page',
                style: TStyles.veryLargeText,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://thiqah.sa/media/pekhnjrb/logo.webp',
                        height: 300,
                        width: 300,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomButton(
                        width: 200,
                        height: 40,
                        textStyle:
                            TStyles.mediumText.copyWith(color: Colors.white),
                        onPressed: viewmodel.navigateToRegister,
                        text: 'Register',
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomButton(
                        width: 200,
                        height: 40,
                        color: Colors.grey[400],
                        textStyle: TStyles.mediumText,
                        onPressed: viewmodel.navigateToLogin,
                        text: 'login',
                      ),
                    ]),
                  ],
                )
              ],
            ),
          );
        });
  }
}
