import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduate_front/core/utils/styles.dart';
import 'package:graduate_front/ui/common/custom_button.dart';
import 'package:graduate_front/ui/common/custom_input_field.dart';
import 'package:graduate_front/ui/register/register_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../core/utils/form_validators.dart';
import '../common/busy_overlay.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
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
                          Text('Register',
                              style:
                                  TStyles.veryLargeText.copyWith(fontSize: 30))
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

                                /// First Name
                                CustomInputField(
                                  label: 'First Name',
                                  hintText: 'input firstname',
                                  validator: FormValidators.nameValidator,
                                  onSave: (value) {
                                    viewmodel.fName = value!;
                                  },
                                ),

                                /// Last Name
                                CustomInputField(
                                  label: 'Last Name',
                                  hintText: 'input Lastname',
                                  validator: FormValidators.nameValidator,
                                  onSave: (value) {
                                    viewmodel.lName = value!;
                                  },
                                ),

                                /// Birthday
                                CustomInputField(
                                  label: 'Birthday',
                                  hintText: 'input DoB',
                                  controller: dobController,
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    DateTime? date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      setState(() {
                                        dobController.text =
                                            '${date.month}/${date.day}/${date.year}';
                                      });
                                    }
                                  },
                                  validator: FormValidators.birthdayValidator,
                                  onSave: (value) {
                                    viewmodel.bDay = value!;
                                  },
                                ),

                                /// Photo
                                CustomInputField(
                                  label: 'Photo',
                                  hintText: 'Add a Profile Ficture',
                                  controller: imgController,
                                  onTap: () async {
                                    try {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      final img = await ImagePicker().pickImage(
                                          source: ImageSource.gallery);
                                      if (img == null) return;
                                      final imgTemp = File(img.path);
                                      image = imgTemp;
                                      if (image != null) {
                                        imgController.text = 'Image Selected!';
                                      }
                                    } catch (e) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Failed to pick Image! $e',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  onSave: (value) {
                                    viewmodel.photo = image;
                                  },
                                ),

                                /// Password
                                CustomInputField(
                                  label: 'Password',
                                  hintText: '**********',
                                  obscure: true,
                                  validator: FormValidators.passwordValidator,
                                  controller: passwordController,
                                  onSave: (value) {
                                    viewmodel.password = value!;
                                  },
                                ),

                                /// Confirm Password
                                CustomInputField(
                                  label: 'Confirm Password',
                                  hintText: '**********',
                                  obscure: true,
                                  validator: (val) =>
                                      FormValidators.confirmPasswordValidator(
                                    val,
                                    passwordController.text,
                                  ),
                                ),

                                SizedBox(height: 10),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                        textStyle: TStyles.smallText
                                            .copyWith(color: Colors.white),
                                        onPressed: () {
                                          viewmodel.submitRegistration(context);
                                        },
                                        text: 'Register')
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
