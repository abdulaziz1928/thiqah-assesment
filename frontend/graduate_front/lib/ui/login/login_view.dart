import 'package:flutter/material.dart';
import 'package:graduate_front/ui/common/busy_overlay.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/form_validators.dart';
import '../../core/utils/styles.dart';
import '../common/custom_input_field.dart';
import '../startup/bb.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewmodel, _) {
          return BusyOverlay(
            isBusy: viewmodel.isBusy,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              body: SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Login',
                            style: TStyles.veryLargeText.copyWith(fontSize: 30))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: viewmodel.formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Email
                              CustomInputField(
                                label: 'Email',
                                hintText: 'input Email address',
                                validator: FormValidators.emailValidator,
                                onSave: (value) {
                                  viewmodel.email = value!;
                                },
                              ),

                              /// Password
                              CustomInputField(
                                label: 'Password',
                                hintText: '**********',
                                obscure: true,
                                validator: FormValidators.passwordValidator,
                                onSave: (value) {
                                  viewmodel.password = value!;
                                },
                              ),

                              SizedBox(height: 10),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomButton(
                                      onPressed: () {
                                        viewmodel.submitLogin(context);
                                      },
                                      textStyle: TStyles.smallText
                                          .copyWith(color: Colors.white),
                                      text: 'Login')
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )),
            ),
          );
        });
  }
}
